package com.enterprise.orders;

import com.enterprise.orders.model.Order;
import com.enterprise.orders.model.OrderStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

/**
 * Repository interface for Order entity operations.
 * 
 * Provides CRUD operations and custom queries for order management.
 */
@Repository
public interface OrderRepository extends JpaRepository<Order, UUID> {
    
    /**
     * Find order by order number
     */
    Optional<Order> findByOrderNumber(String orderNumber);
    
    /**
     * Find order by correlation ID (for distributed tracing)
     */
    Optional<Order> findByCorrelationId(String correlationId);
    
    /**
     * Find all orders for a specific customer
     */
    List<Order> findByCustomerId(UUID customerId);
    
    /**
     * Find orders by status
     */
    List<Order> findByStatus(OrderStatus status);
    
    /**
     * Find orders by customer and status
     */
    List<Order> findByCustomerIdAndStatus(UUID customerId, OrderStatus status);
    
    /**
     * Find orders created within a date range
     */
    @Query("SELECT o FROM Order o WHERE o.createdAt BETWEEN :startDate AND :endDate")
    List<Order> findOrdersCreatedBetween(
        @Param("startDate") LocalDateTime startDate,
        @Param("endDate") LocalDateTime endDate
    );
    
    /**
     * Find orders by payment ID
     */
    Optional<Order> findByPaymentId(UUID paymentId);
    
    /**
     * Find orders pending confirmation (validated but not confirmed)
     * This query is used to identify orders stuck in processing
     */
    @Query("SELECT o FROM Order o WHERE o.status = 'VALIDATED' AND o.createdAt < :threshold")
    List<Order> findStaleValidatedOrders(@Param("threshold") LocalDateTime threshold);
    
    /**
     * Count orders by status
     */
    long countByStatus(OrderStatus status);
    
    /**
     * Find recent orders for a customer (last 30 days)
     */
    @Query("SELECT o FROM Order o WHERE o.customerId = :customerId AND o.createdAt > :since ORDER BY o.createdAt DESC")
    List<Order> findRecentOrdersByCustomer(
        @Param("customerId") UUID customerId,
        @Param("since") LocalDateTime since
    );
    
    /**
     * Check if order exists by order number
     */
    boolean existsByOrderNumber(String orderNumber);
}

// Made with Bob
