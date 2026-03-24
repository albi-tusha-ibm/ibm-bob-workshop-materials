package com.enterprise.orders;

import com.enterprise.orders.model.Order;
import com.enterprise.orders.model.OrderStatus;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Service class for order business logic.
 * 
 * Handles order creation, validation, status updates, and event publishing.
 * 
 * KNOWN ISSUE: Memory leak in order cache - WeakHashMap not releasing references properly
 * See: INC-2024-003-memory-leak.md
 */
@Service
public class OrderService {
    
    private static final Logger logger = LoggerFactory.getLogger(OrderService.class);
    
    private final OrderRepository orderRepository;
    private final KafkaTemplate<String, String> kafkaTemplate;
    private final ObjectMapper objectMapper;
    
    // MEMORY LEAK: This cache grows unbounded and doesn't release references
    // WeakHashMap was intended to allow GC, but strong references elsewhere prevent cleanup
    private final Map<String, Order> orderCache = new WeakHashMap<>();
    
    // Additional cache for "quick lookup" - this is the actual culprit
    // ConcurrentHashMap holds strong references that prevent WeakHashMap from working
    private final Map<String, String> orderNumberToIdCache = new ConcurrentHashMap<>();
    
    @Autowired
    public OrderService(OrderRepository orderRepository, 
                       KafkaTemplate<String, String> kafkaTemplate,
                       ObjectMapper objectMapper) {
        this.orderRepository = orderRepository;
        this.kafkaTemplate = kafkaTemplate;
        this.objectMapper = objectMapper;
    }
    
    /**
     * Create a new order
     * 
     * @param order The order to create
     * @return The created order with generated ID
     */
    @Transactional
    public Order createOrder(Order order) {
        String correlationId = order.getCorrelationId();
        MDC.put("correlationId", correlationId);
        
        try {
            logger.info("Creating order for customer: {}", order.getCustomerId());
            
            // Validate order
            order.validate();
            
            // Save to database
            Order savedOrder = orderRepository.save(order);
            
            // Cache the order (MEMORY LEAK: never evicted properly)
            cacheOrder(savedOrder);
            
            // Publish order created event
            publishOrderEvent("order-created", savedOrder);
            
            logger.info("Order created successfully: {}", savedOrder.getOrderNumber());
            return savedOrder;
            
        } catch (Exception e) {
            logger.error("Failed to create order", e);
            throw new OrderServiceException("Failed to create order: " + e.getMessage(), e);
        } finally {
            MDC.remove("correlationId");
        }
    }
    
    /**
     * Get order by ID
     * 
     * @param orderId The order ID
     * @return The order if found
     */
    public Optional<Order> getOrderById(UUID orderId) {
        logger.debug("Fetching order by ID: {}", orderId);
        
        // Try cache first (this contributes to memory issues)
        Order cachedOrder = getCachedOrderById(orderId);
        if (cachedOrder != null) {
            logger.debug("Order found in cache: {}", orderId);
            return Optional.of(cachedOrder);
        }
        
        // Fetch from database
        Optional<Order> order = orderRepository.findById(orderId);
        order.ifPresent(this::cacheOrder);
        
        return order;
    }
    
    /**
     * Get order by order number
     */
    public Optional<Order> getOrderByOrderNumber(String orderNumber) {
        logger.debug("Fetching order by order number: {}", orderNumber);
        
        // Check cache using the problematic secondary cache
        String cachedId = orderNumberToIdCache.get(orderNumber);
        if (cachedId != null) {
            Order cachedOrder = orderCache.get(cachedId);
            if (cachedOrder != null) {
                logger.debug("Order found in cache: {}", orderNumber);
                return Optional.of(cachedOrder);
            }
        }
        
        Optional<Order> order = orderRepository.findByOrderNumber(orderNumber);
        order.ifPresent(this::cacheOrder);
        
        return order;
    }
    
    /**
     * Update order status
     * 
     * @param orderId The order ID
     * @param newStatus The new status
     * @return The updated order
     */
    @Transactional
    public Order updateOrderStatus(UUID orderId, OrderStatus newStatus) {
        String correlationId = UUID.randomUUID().toString();
        MDC.put("correlationId", correlationId);
        
        try {
            logger.info("Updating order {} to status {}", orderId, newStatus);
            
            Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new OrderNotFoundException("Order not found: " + orderId));
            
            OrderStatus oldStatus = order.getStatus();
            
            // Transition to new status based on business rules
            switch (newStatus) {
                case VALIDATED:
                    order.markAsValidated();
                    break;
                case CONFIRMED:
                    order.markAsConfirmed();
                    break;
                case SHIPPED:
                    order.markAsShipped();
                    break;
                case DELIVERED:
                    order.markAsDelivered();
                    break;
                case CANCELLED:
                    order.cancel();
                    break;
                default:
                    throw new IllegalArgumentException("Invalid status transition");
            }
            
            Order updatedOrder = orderRepository.save(order);
            
            // Update cache (adds to memory leak)
            cacheOrder(updatedOrder);
            
            // Publish status change event
            publishOrderStatusChangeEvent(updatedOrder, oldStatus, newStatus);
            
            logger.info("Order status updated successfully: {} -> {}", oldStatus, newStatus);
            return updatedOrder;
            
        } catch (Exception e) {
            logger.error("Failed to update order status", e);
            throw new OrderServiceException("Failed to update order status: " + e.getMessage(), e);
        } finally {
            MDC.remove("correlationId");
        }
    }
    
    /**
     * Validate order (check inventory, customer, etc.)
     */
    @Transactional
    public Order validateOrder(UUID orderId) {
        String correlationId = UUID.randomUUID().toString();
        MDC.put("correlationId", correlationId);
        
        try {
            logger.info("Validating order: {}", orderId);
            
            Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new OrderNotFoundException("Order not found: " + orderId));
            
            if (order.getStatus() != OrderStatus.CREATED) {
                throw new IllegalStateException("Order must be in CREATED status to validate");
            }
            
            // Simulate validation logic (would call inventory service, customer service, etc.)
            // This is where slow database queries occur, causing Kafka consumer lag
            performValidationChecks(order);
            
            order.markAsValidated();
            Order validatedOrder = orderRepository.save(order);
            
            // Cache the validated order
            cacheOrder(validatedOrder);
            
            // Publish validation event
            publishOrderEvent("order-validated", validatedOrder);
            
            logger.info("Order validated successfully: {}", order.getOrderNumber());
            return validatedOrder;
            
        } catch (Exception e) {
            logger.error("Failed to validate order", e);
            throw new OrderServiceException("Failed to validate order: " + e.getMessage(), e);
        } finally {
            MDC.remove("correlationId");
        }
    }
    
    /**
     * Confirm order after payment
     */
    @Transactional
    public Order confirmOrder(UUID orderId, UUID paymentId) {
        String correlationId = UUID.randomUUID().toString();
        MDC.put("correlationId", correlationId);
        
        try {
            logger.info("Confirming order: {} with payment: {}", orderId, paymentId);
            
            Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new OrderNotFoundException("Order not found: " + orderId));
            
            order.setPaymentId(paymentId);
            order.markAsConfirmed();
            
            Order confirmedOrder = orderRepository.save(order);
            
            // Cache the confirmed order
            cacheOrder(confirmedOrder);
            
            // Publish confirmation event
            publishOrderEvent("order-confirmed", confirmedOrder);
            
            logger.info("Order confirmed successfully: {}", order.getOrderNumber());
            return confirmedOrder;
            
        } catch (Exception e) {
            logger.error("Failed to confirm order", e);
            throw new OrderServiceException("Failed to confirm order: " + e.getMessage(), e);
        } finally {
            MDC.remove("correlationId");
        }
    }
    
    /**
     * Get orders by customer ID
     */
    public List<Order> getOrdersByCustomerId(UUID customerId) {
        logger.debug("Fetching orders for customer: {}", customerId);
        return orderRepository.findByCustomerId(customerId);
    }
    
    /**
     * Get orders by status
     */
    public List<Order> getOrdersByStatus(OrderStatus status) {
        logger.debug("Fetching orders with status: {}", status);
        return orderRepository.findByStatus(status);
    }
    
    // Private helper methods
    
    /**
     * Cache an order (MEMORY LEAK SOURCE)
     * 
     * The combination of WeakHashMap and ConcurrentHashMap creates a memory leak:
     * - WeakHashMap should allow GC of unused orders
     * - But ConcurrentHashMap holds strong references to order IDs
     * - This prevents WeakHashMap from releasing the Order objects
     * - Over time, all orders remain in memory
     */
    private void cacheOrder(Order order) {
        String cacheKey = order.getId().toString();
        orderCache.put(cacheKey, order);
        orderNumberToIdCache.put(order.getOrderNumber(), cacheKey);
        
        // Log cache size periodically (helps identify the leak)
        if (orderCache.size() % 100 == 0) {
            logger.warn("Order cache size: {}, ID cache size: {}", 
                orderCache.size(), orderNumberToIdCache.size());
        }
    }
    
    /**
     * Get cached order by ID
     */
    private Order getCachedOrderById(UUID orderId) {
        return orderCache.get(orderId.toString());
    }
    
    /**
     * Perform validation checks (SLOW DATABASE QUERIES)
     * 
     * This method causes Kafka consumer lag by blocking consumer threads
     * with slow database queries.
     */
    private void performValidationChecks(Order order) {
        // Simulate slow database query (missing index on customer_id)
        // In production, this takes 500-1000ms per order
        try {
            Thread.sleep(50); // Simulated delay
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
        
        // Additional validation logic would go here
        logger.debug("Validation checks completed for order: {}", order.getId());
    }
    
    /**
     * Publish order event to Kafka
     */
    private void publishOrderEvent(String eventType, Order order) {
        try {
            Map<String, Object> event = new HashMap<>();
            event.put("eventType", eventType);
            event.put("orderId", order.getId().toString());
            event.put("orderNumber", order.getOrderNumber());
            event.put("customerId", order.getCustomerId().toString());
            event.put("status", order.getStatus().toString());
            event.put("totalAmount", order.getTotalAmount());
            event.put("correlationId", order.getCorrelationId());
            event.put("timestamp", LocalDateTime.now().toString());
            
            String eventJson = objectMapper.writeValueAsString(event);
            
            kafkaTemplate.send("order-events", order.getId().toString(), eventJson);
            
            logger.debug("Published {} event for order: {}", eventType, order.getOrderNumber());
            
        } catch (JsonProcessingException e) {
            logger.error("Failed to serialize order event", e);
            // Don't throw exception - event publishing failure shouldn't fail the transaction
        }
    }
    
    /**
     * Publish order status change event
     */
    private void publishOrderStatusChangeEvent(Order order, OrderStatus oldStatus, OrderStatus newStatus) {
        try {
            Map<String, Object> event = new HashMap<>();
            event.put("eventType", "order-status-changed");
            event.put("orderId", order.getId().toString());
            event.put("orderNumber", order.getOrderNumber());
            event.put("oldStatus", oldStatus.toString());
            event.put("newStatus", newStatus.toString());
            event.put("correlationId", order.getCorrelationId());
            event.put("timestamp", LocalDateTime.now().toString());
            
            String eventJson = objectMapper.writeValueAsString(event);
            
            kafkaTemplate.send("order-events", order.getId().toString(), eventJson);
            
            logger.debug("Published status change event: {} -> {}", oldStatus, newStatus);
            
        } catch (JsonProcessingException e) {
            logger.error("Failed to serialize status change event", e);
        }
    }
    
    /**
     * Get cache statistics (for monitoring)
     */
    public Map<String, Integer> getCacheStatistics() {
        Map<String, Integer> stats = new HashMap<>();
        stats.put("orderCacheSize", orderCache.size());
        stats.put("idCacheSize", orderNumberToIdCache.size());
        return stats;
    }
}

// Made with Bob
