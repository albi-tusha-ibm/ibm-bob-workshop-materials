package com.enterprise.orders;

import com.enterprise.orders.model.Order;
import com.enterprise.orders.model.OrderStatus;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * REST Controller for order management endpoints.
 * 
 * Provides APIs for:
 * - Creating orders
 * - Retrieving orders
 * - Updating order status
 * - Querying orders by various criteria
 */
@RestController
@RequestMapping("/api/v1/orders")
public class OrderController {
    
    private static final Logger logger = LoggerFactory.getLogger(OrderController.class);
    
    private final OrderService orderService;
    
    @Autowired
    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }
    
    /**
     * Create a new order
     * 
     * POST /api/v1/orders
     */
    @PostMapping
    public ResponseEntity<Order> createOrder(@Valid @RequestBody Order order) {
        String correlationId = order.getCorrelationId();
        if (correlationId == null) {
            correlationId = UUID.randomUUID().toString();
            order.setCorrelationId(correlationId);
        }
        
        MDC.put("correlationId", correlationId);
        
        try {
            logger.info("Received request to create order for customer: {}", order.getCustomerId());
            
            Order createdOrder = orderService.createOrder(order);
            
            logger.info("Order created successfully: {}", createdOrder.getOrderNumber());
            return ResponseEntity.status(HttpStatus.CREATED).body(createdOrder);
            
        } catch (IllegalStateException e) {
            logger.warn("Invalid order data: {}", e.getMessage());
            return ResponseEntity.badRequest().build();
        } catch (Exception e) {
            logger.error("Failed to create order", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        } finally {
            MDC.remove("correlationId");
        }
    }
    
    /**
     * Get order by ID
     * 
     * GET /api/v1/orders/{id}
     */
    @GetMapping("/{id}")
    public ResponseEntity<Order> getOrderById(@PathVariable UUID id) {
        String correlationId = UUID.randomUUID().toString();
        MDC.put("correlationId", correlationId);
        
        try {
            logger.debug("Fetching order: {}", id);
            
            return orderService.getOrderById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
                
        } finally {
            MDC.remove("correlationId");
        }
    }
    
    /**
     * Get order by order number
     * 
     * GET /api/v1/orders/by-number/{orderNumber}
     */
    @GetMapping("/by-number/{orderNumber}")
    public ResponseEntity<Order> getOrderByOrderNumber(@PathVariable String orderNumber) {
        String correlationId = UUID.randomUUID().toString();
        MDC.put("correlationId", correlationId);
        
        try {
            logger.debug("Fetching order by number: {}", orderNumber);
            
            return orderService.getOrderByOrderNumber(orderNumber)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
                
        } finally {
            MDC.remove("correlationId");
        }
    }
    
    /**
     * Update order status
     * 
     * PUT /api/v1/orders/{id}/status
     */
    @PutMapping("/{id}/status")
    public ResponseEntity<Order> updateOrderStatus(
            @PathVariable UUID id,
            @RequestBody Map<String, String> statusUpdate) {
        
        String correlationId = UUID.randomUUID().toString();
        MDC.put("correlationId", correlationId);
        
        try {
            String statusStr = statusUpdate.get("status");
            if (statusStr == null) {
                logger.warn("Status not provided in request");
                return ResponseEntity.badRequest().build();
            }
            
            OrderStatus newStatus = OrderStatus.valueOf(statusStr.toUpperCase());
            
            logger.info("Updating order {} to status {}", id, newStatus);
            
            Order updatedOrder = orderService.updateOrderStatus(id, newStatus);
            
            return ResponseEntity.ok(updatedOrder);
            
        } catch (IllegalArgumentException e) {
            logger.warn("Invalid status value: {}", statusUpdate.get("status"));
            return ResponseEntity.badRequest().build();
        } catch (OrderNotFoundException e) {
            logger.warn("Order not found: {}", id);
            return ResponseEntity.notFound().build();
        } catch (IllegalStateException e) {
            logger.warn("Invalid status transition: {}", e.getMessage());
            return ResponseEntity.status(HttpStatus.CONFLICT).build();
        } catch (Exception e) {
            logger.error("Failed to update order status", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        } finally {
            MDC.remove("correlationId");
        }
    }
    
    /**
     * Validate an order
     * 
     * POST /api/v1/orders/{id}/validate
     */
    @PostMapping("/{id}/validate")
    public ResponseEntity<Order> validateOrder(@PathVariable UUID id) {
        String correlationId = UUID.randomUUID().toString();
        MDC.put("correlationId", correlationId);
        
        try {
            logger.info("Validating order: {}", id);
            
            Order validatedOrder = orderService.validateOrder(id);
            
            return ResponseEntity.ok(validatedOrder);
            
        } catch (OrderNotFoundException e) {
            logger.warn("Order not found: {}", id);
            return ResponseEntity.notFound().build();
        } catch (IllegalStateException e) {
            logger.warn("Cannot validate order: {}", e.getMessage());
            return ResponseEntity.status(HttpStatus.CONFLICT).build();
        } catch (Exception e) {
            logger.error("Failed to validate order", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        } finally {
            MDC.remove("correlationId");
        }
    }
    
    /**
     * Confirm an order (after payment)
     * 
     * POST /api/v1/orders/{id}/confirm
     */
    @PostMapping("/{id}/confirm")
    public ResponseEntity<Order> confirmOrder(
            @PathVariable UUID id,
            @RequestBody Map<String, String> confirmationData) {
        
        String correlationId = UUID.randomUUID().toString();
        MDC.put("correlationId", correlationId);
        
        try {
            String paymentIdStr = confirmationData.get("paymentId");
            if (paymentIdStr == null) {
                logger.warn("Payment ID not provided");
                return ResponseEntity.badRequest().build();
            }
            
            UUID paymentId = UUID.fromString(paymentIdStr);
            
            logger.info("Confirming order: {} with payment: {}", id, paymentId);
            
            Order confirmedOrder = orderService.confirmOrder(id, paymentId);
            
            return ResponseEntity.ok(confirmedOrder);
            
        } catch (IllegalArgumentException e) {
            logger.warn("Invalid payment ID format");
            return ResponseEntity.badRequest().build();
        } catch (OrderNotFoundException e) {
            logger.warn("Order not found: {}", id);
            return ResponseEntity.notFound().build();
        } catch (IllegalStateException e) {
            logger.warn("Cannot confirm order: {}", e.getMessage());
            return ResponseEntity.status(HttpStatus.CONFLICT).build();
        } catch (Exception e) {
            logger.error("Failed to confirm order", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        } finally {
            MDC.remove("correlationId");
        }
    }
    
    /**
     * Get orders by customer ID
     * 
     * GET /api/v1/orders/customer/{customerId}
     */
    @GetMapping("/customer/{customerId}")
    public ResponseEntity<List<Order>> getOrdersByCustomerId(@PathVariable UUID customerId) {
        String correlationId = UUID.randomUUID().toString();
        MDC.put("correlationId", correlationId);
        
        try {
            logger.debug("Fetching orders for customer: {}", customerId);
            
            List<Order> orders = orderService.getOrdersByCustomerId(customerId);
            
            return ResponseEntity.ok(orders);
            
        } finally {
            MDC.remove("correlationId");
        }
    }
    
    /**
     * Get orders by status
     * 
     * GET /api/v1/orders/status/{status}
     */
    @GetMapping("/status/{status}")
    public ResponseEntity<List<Order>> getOrdersByStatus(@PathVariable String status) {
        String correlationId = UUID.randomUUID().toString();
        MDC.put("correlationId", correlationId);
        
        try {
            OrderStatus orderStatus = OrderStatus.valueOf(status.toUpperCase());
            
            logger.debug("Fetching orders with status: {}", orderStatus);
            
            List<Order> orders = orderService.getOrdersByStatus(orderStatus);
            
            return ResponseEntity.ok(orders);
            
        } catch (IllegalArgumentException e) {
            logger.warn("Invalid status value: {}", status);
            return ResponseEntity.badRequest().build();
        } finally {
            MDC.remove("correlationId");
        }
    }
    
    /**
     * Health check endpoint
     * 
     * GET /api/v1/orders/health
     */
    @GetMapping("/health")
    public ResponseEntity<Map<String, Object>> healthCheck() {
        Map<String, Object> health = Map.of(
            "status", "UP",
            "service", "order-service",
            "timestamp", System.currentTimeMillis()
        );
        return ResponseEntity.ok(health);
    }
    
    /**
     * Get cache statistics (for debugging memory leak)
     * 
     * GET /api/v1/orders/cache-stats
     */
    @GetMapping("/cache-stats")
    public ResponseEntity<Map<String, Integer>> getCacheStats() {
        Map<String, Integer> stats = orderService.getCacheStatistics();
        return ResponseEntity.ok(stats);
    }
    
    /**
     * Exception handler for validation errors
     */
    @ExceptionHandler(IllegalArgumentException.class)
    public ResponseEntity<Map<String, String>> handleIllegalArgument(IllegalArgumentException e) {
        logger.warn("Invalid argument: {}", e.getMessage());
        return ResponseEntity.badRequest()
            .body(Map.of("error", e.getMessage()));
    }
    
    /**
     * Exception handler for order not found
     */
    @ExceptionHandler(OrderNotFoundException.class)
    public ResponseEntity<Map<String, String>> handleOrderNotFound(OrderNotFoundException e) {
        logger.warn("Order not found: {}", e.getMessage());
        return ResponseEntity.status(HttpStatus.NOT_FOUND)
            .body(Map.of("error", e.getMessage()));
    }
    
    /**
     * Exception handler for general errors
     */
    @ExceptionHandler(Exception.class)
    public ResponseEntity<Map<String, String>> handleGeneralError(Exception e) {
        logger.error("Unexpected error", e);
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
            .body(Map.of("error", "Internal server error"));
    }
}

// Made with Bob
