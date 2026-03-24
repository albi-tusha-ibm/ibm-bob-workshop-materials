package com.enterprise.payments;

import com.enterprise.payments.model.Payment;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/payments")
public class PaymentController {
    
    private static final Logger logger = LoggerFactory.getLogger(PaymentController.class);
    
    private final PaymentProcessor paymentProcessor;
    
    @Autowired
    public PaymentController(PaymentProcessor paymentProcessor) {
        this.paymentProcessor = paymentProcessor;
    }
    
    @PostMapping
    public ResponseEntity<Payment> processPayment(@Valid @RequestBody Payment payment) {
        String correlationId = payment.getCorrelationId();
        if (correlationId == null) {
            correlationId = UUID.randomUUID().toString();
            payment.setCorrelationId(correlationId);
        }
        
        MDC.put("correlationId", correlationId);
        
        try {
            logger.info("Received payment request for order: {}", payment.getOrderId());
            
            Payment processedPayment = paymentProcessor.processPayment(payment);
            
            if (processedPayment.getStatus() == com.enterprise.payments.model.PaymentStatus.COMPLETED) {
                return ResponseEntity.ok(processedPayment);
            } else {
                return ResponseEntity.status(HttpStatus.PAYMENT_REQUIRED).body(processedPayment);
            }
            
        } catch (Exception e) {
            logger.error("Failed to process payment", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        } finally {
            MDC.remove("correlationId");
        }
    }
    
    @GetMapping("/health")
    public ResponseEntity<Map<String, Object>> healthCheck() {
        return ResponseEntity.ok(Map.of(
            "status", "UP",
            "service", "payment-service"
        ));
    }
}
