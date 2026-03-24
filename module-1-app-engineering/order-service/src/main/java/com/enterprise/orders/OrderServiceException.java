package com.enterprise.orders;

/**
 * General exception for order service operations
 */
public class OrderServiceException extends RuntimeException {
    
    public OrderServiceException(String message) {
        super(message);
    }
    
    public OrderServiceException(String message, Throwable cause) {
        super(message, cause);
    }
}

// Made with Bob
