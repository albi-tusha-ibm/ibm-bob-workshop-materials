package com.enterprise.orders.model;

/**
 * Order status enumeration representing the lifecycle of an order.
 * 
 * Status Flow:
 * CREATED -> VALIDATED -> CONFIRMED -> SHIPPED -> DELIVERED
 * 
 * Any status can transition to CANCELLED (except DELIVERED)
 */
public enum OrderStatus {
    /**
     * Order has been created but not yet validated
     */
    CREATED,
    
    /**
     * Order has been validated (items available, customer verified)
     */
    VALIDATED,
    
    /**
     * Order has been confirmed (payment completed, ready for fulfillment)
     */
    CONFIRMED,
    
    /**
     * Order has been shipped to customer
     */
    SHIPPED,
    
    /**
     * Order has been delivered to customer
     */
    DELIVERED,
    
    /**
     * Order has been cancelled
     */
    CANCELLED
}

// Made with Bob
