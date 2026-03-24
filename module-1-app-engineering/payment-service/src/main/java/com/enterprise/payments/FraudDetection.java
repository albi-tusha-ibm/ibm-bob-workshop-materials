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
