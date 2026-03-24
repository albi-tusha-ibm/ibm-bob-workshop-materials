package com.enterprise.payments;

import com.enterprise.payments.model.Payment;
import com.enterprise.payments.model.PaymentStatus;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.client.ResourceAccessException;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

/**
 * Payment processor that integrates with external payment gateway.
 * 
 * KNOWN ISSUE: External API calls timing out (8-12 seconds)
 * See: INC-2024-001-payment-timeout.md
 */
@Service
public class PaymentProcessor {
    
    private static final Logger logger = LoggerFactory.getLogger(PaymentProcessor.class);
    
    @Value("${payment.gateway.url:https://api.stripeconnect.com}")
    private String gatewayUrl;
    
    @Value("${payment.gateway.timeout:5000}")
    private int timeoutMs;
    
    private final RestTemplate restTemplate;
    private final FraudDetection fraudDetection;
    
    public PaymentProcessor(RestTemplate restTemplate, FraudDetection fraudDetection) {
        this.restTemplate = restTemplate;
        this.fraudDetection = fraudDetection;
    }
    
    /**
     * Process payment through external gateway
     * 
     * ISSUE: This method experiences timeouts due to slow external API
     */
    public Payment processPayment(Payment payment) {
        String correlationId = payment.getCorrelationId();
        MDC.put("correlationId", correlationId);
        
        LocalDateTime startTime = LocalDateTime.now();
        
        try {
            logger.info("Processing payment {} for order {}", payment.getId(), payment.getOrderId());
            
            // Fraud detection check
            int fraudScore = fraudDetection.calculateFraudScore(payment);
            payment.setFraudScore(fraudScore);
            
            if (fraudScore > 80) {
                logger.warn("High fraud score detected: {}", fraudScore);
                payment.setFraudCheckPassed(false);
                payment.markAsFailed("Failed fraud check");
                return payment;
            }
            
            payment.setFraudCheckPassed(true);
            payment.markAsProcessing();
            
            // Call external payment gateway
            // PROBLEM: This call is taking 8-12 seconds instead of 1-2 seconds
            Map<String, Object> gatewayRequest = buildGatewayRequest(payment);
            
            logger.debug("Calling payment gateway: {}", gatewayUrl);
            
            try {
                // This is where the timeout occurs
                Map<String, Object> response = restTemplate.postForObject(
                    gatewayUrl + "/v1/charges",
                    gatewayRequest,
                    Map.class
                );
                
                Duration duration = Duration.between(startTime, LocalDateTime.now());
                logger.info("Payment gateway responded in {}ms", duration.toMillis());
                
                if (response != null && "success".equals(response.get("status"))) {
                    String transactionId = (String) response.get("transaction_id");
                    payment.markAsCompleted(transactionId);
                    payment.setGatewayResponse(response.toString());
                    logger.info("Payment completed successfully: {}", transactionId);
                } else {
                    String errorMsg = response != null ? (String) response.get("error") : "Unknown error";
                    payment.markAsFailed(errorMsg);
                    logger.error("Payment failed: {}", errorMsg);
                }
                
            } catch (ResourceAccessException e) {
                // Timeout exception
                Duration duration = Duration.between(startTime, LocalDateTime.now());
                logger.error("Payment gateway timeout after {}ms (configured: {}ms)", 
                    duration.toMillis(), timeoutMs, e);
                payment.markAsFailed("Gateway timeout");
            }
            
            return payment;
            
        } catch (Exception e) {
            logger.error("Unexpected error processing payment", e);
            payment.markAsFailed("Internal error: " + e.getMessage());
            return payment;
        } finally {
            MDC.remove("correlationId");
        }
    }
    
    private Map<String, Object> buildGatewayRequest(Payment payment) {
        Map<String, Object> request = new HashMap<>();
        request.put("amount", payment.getAmount());
        request.put("currency", payment.getCurrency());
        request.put("payment_method", payment.getPaymentMethod());
        request.put("customer_id", payment.getCustomerId().toString());
        request.put("order_id", payment.getOrderId().toString());
        request.put("idempotency_key", payment.getCorrelationId());
        return request;
    }
}
