#!/bin/bash

# Script to generate all remaining files for Module 1: Application Engineering
# This creates realistic enterprise-quality content for the workshop

set -e

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$BASE_DIR"

echo "Generating Module 1 files..."

# Payment Service Status Enum
cat > payment-service/src/main/java/com/enterprise/payments/model/PaymentStatus.java << 'EOF'
package com.enterprise.payments.model;

public enum PaymentStatus {
    PENDING,
    PROCESSING,
    COMPLETED,
    FAILED,
    REFUNDED,
    CANCELLED
}
EOF

# Payment Processor (with timeout issues)
cat > payment-service/src/main/java/com/enterprise/payments/PaymentProcessor.java << 'EOF'
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
EOF

# Fraud Detection
cat > payment-service/src/main/java/com/enterprise/payments/FraudDetection.java << 'EOF'
package com.enterprise.payments;

import com.enterprise.payments.model.Payment;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;

/**
 * Rule-based fraud detection engine
 */
@Component
public class FraudDetection {
    
    private static final Logger logger = LoggerFactory.getLogger(FraudDetection.class);
    
    public int calculateFraudScore(Payment payment) {
        int score = 0;
        
        // Rule 1: High amount transactions
        if (payment.getAmount().compareTo(new BigDecimal("1000")) > 0) {
            score += 30;
            logger.debug("High amount detected: +30 points");
        }
        
        // Rule 2: Very high amount
        if (payment.getAmount().compareTo(new BigDecimal("5000")) > 0) {
            score += 50;
            logger.debug("Very high amount detected: +50 points");
        }
        
        // Additional rules would go here
        // - Velocity checks
        // - Geographic anomalies
        // - Device fingerprinting
        // - Historical patterns
        
        logger.info("Fraud score calculated: {} for payment {}", score, payment.getId());
        return score;
    }
}
EOF

# Payment Controller
cat > payment-service/src/main/java/com/enterprise/payments/PaymentController.java << 'EOF'
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
EOF

# Payment Service Application Config
cat > payment-service/src/main/resources/application.yml << 'EOF'
spring:
  application:
    name: payment-service
  
  datasource:
    url: jdbc:postgresql://localhost:5432/payments_db
    username: payments_user
    password: ${DB_PASSWORD:payments_pass}

server:
  port: 8082

payment:
  gateway:
    url: https://api.stripeconnect.com
    timeout: 5000

logging:
  level:
    root: INFO
    com.enterprise.payments: DEBUG
  pattern:
    console: "%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{36} [%X{correlationId}] - %msg%n"
EOF

# Payment Service POM
cat > payment-service/pom.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
         http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>3.1.5</version>
    </parent>

    <groupId>com.enterprise</groupId>
    <artifactId>payment-service</artifactId>
    <version>2.4.1</version>
    <name>Payment Service</name>

    <properties>
        <java.version>17</java.version>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-jpa</artifactId>
        </dependency>
        <dependency>
            <groupId>org.postgresql</groupId>
            <artifactId>postgresql</artifactId>
        </dependency>
    </dependencies>
</project>
EOF

# Payment Service README
cat > payment-service/README.md << 'EOF'
# Payment Service

Processes payments through external payment gateway (StripeConnect).

## Known Issues

### Payment Timeouts (P1 - Critical)
- 15% of payments timing out
- External API taking 8-12 seconds
- See: INC-2024-001-payment-timeout.md

## API Endpoints

- POST /api/v1/payments - Process payment
- GET /api/v1/payments/health - Health check
EOF

echo "Payment service files created ✓"

# Inventory Service files
cat > inventory-service/src/main/java/com/enterprise/inventory/model/Product.java << 'EOF'
package com.enterprise.inventory.model;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.util.UUID;

@Entity
@Table(name = "products")
public class Product {
    
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;
    
    @Column(name = "sku", unique = true, nullable = false)
    private String sku;
    
    @Column(name = "name", nullable = false)
    private String name;
    
    @Column(name = "stock_quantity", nullable = false)
    private Integer stockQuantity;
    
    @Column(name = "reserved_quantity", nullable = false)
    private Integer reservedQuantity = 0;
    
    @Column(name = "price", nullable = false)
    private BigDecimal price;
    
    // Getters and setters
    public UUID getId() { return id; }
    public void setId(UUID id) { this.id = id; }
    
    public String getSku() { return sku; }
    public void setSku(String sku) { this.sku = sku; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public Integer getStockQuantity() { return stockQuantity; }
    public void setStockQuantity(Integer stockQuantity) { this.stockQuantity = stockQuantity; }
    
    public Integer getReservedQuantity() { return reservedQuantity; }
    public void setReservedQuantity(Integer reservedQuantity) { this.reservedQuantity = reservedQuantity; }
    
    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }
    
    public int getAvailableQuantity() {
        return stockQuantity - reservedQuantity;
    }
}
EOF

cat > inventory-service/src/main/java/com/enterprise/inventory/StockManager.java << 'EOF'
package com.enterprise.inventory;

import com.enterprise.inventory.model.Product;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

/**
 * Manages inventory stock levels and reservations
 */
@Service
public class StockManager {
    
    private static final Logger logger = LoggerFactory.getLogger(StockManager.class);
    
    @Transactional
    public boolean reserveStock(UUID productId, int quantity) {
        logger.info("Reserving {} units of product {}", quantity, productId);
        
        // Implementation would check available stock and reserve
        // Potential race condition if not properly synchronized
        
        return true;
    }
    
    @Transactional
    public void releaseStock(UUID productId, int quantity) {
        logger.info("Releasing {} units of product {}", quantity, productId);
        // Implementation would release reserved stock
    }
}
EOF

cat > inventory-service/src/main/java/com/enterprise/inventory/InventoryController.java << 'EOF'
package com.enterprise.inventory;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/inventory")
public class InventoryController {
    
    private final StockManager stockManager;
    
    public InventoryController(StockManager stockManager) {
        this.stockManager = stockManager;
    }
    
    @PostMapping("/reserve")
    public ResponseEntity<Map<String, Object>> reserveStock(
            @RequestBody Map<String, Object> request) {
        UUID productId = UUID.fromString((String) request.get("productId"));
        int quantity = (Integer) request.get("quantity");
        
        boolean reserved = stockManager.reserveStock(productId, quantity);
        
        return ResponseEntity.ok(Map.of("reserved", reserved));
    }
    
    @GetMapping("/health")
    public ResponseEntity<Map<String, String>> healthCheck() {
        return ResponseEntity.ok(Map.of("status", "UP"));
    }
}
EOF

cat > inventory-service/src/main/resources/application.yml << 'EOF'
spring:
  application:
    name: inventory-service

server:
  port: 8083

logging:
  level:
    root: INFO
    com.enterprise.inventory: DEBUG
EOF

cat > inventory-service/pom.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>3.1.5</version>
    </parent>
    <groupId>com.enterprise</groupId>
    <artifactId>inventory-service</artifactId>
    <version>1.8.2</version>
    <name>Inventory Service</name>
    <properties>
        <java.version>17</java.version>
    </properties>
    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-jpa</artifactId>
        </dependency>
        <dependency>
            <groupId>org.postgresql</groupId>
            <artifactId>postgresql</artifactId>
        </dependency>
    </dependencies>
</project>
EOF

cat > inventory-service/README.md << 'EOF'
# Inventory Service

Manages product stock levels across warehouses.

## API Endpoints

- POST /api/v1/inventory/reserve - Reserve stock
- GET /api/v1/inventory/health - Health check
EOF

echo "Inventory service files created ✓"

echo "All service files generated successfully!"
echo "Total files created: 15+"

# Made with Bob
