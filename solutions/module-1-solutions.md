# Module 1: Application Engineering - Reference Solutions

This document provides reference solutions for the Module 1 exercises. Remember: these are **examples to inspire**, not prescriptive answers. Bob can help you discover multiple valid approaches to each problem.

---

## Exercise 1: Search & Discovery

### Task 1: Find all REST endpoints across the three services

**Example Bob Prompts:**
- "List all REST API endpoints defined in the order-service, payment-service, and inventory-service"
- "Show me all @RestController and @RequestMapping annotations across the microservices"

**Expected Findings:**

**Order Service:**
- `POST /api/orders` - Create new order
- `GET /api/orders/{id}` - Get order by ID
- `GET /api/orders` - List orders
- `PUT /api/orders/{id}/status` - Update order status
- `DELETE /api/orders/{id}` - Cancel order

**Payment Service:**
- `POST /api/payments` - Process payment
- `GET /api/payments/{id}` - Get payment status
- `POST /api/payments/{id}/refund` - Refund payment
- `GET /api/payments/validate` - Validate payment details

**Inventory Service:**
- `GET /api/inventory/{productId}` - Check stock availability
- `POST /api/inventory/reserve` - Reserve inventory
- `POST /api/inventory/release` - Release reservation
- `PUT /api/inventory/{productId}/stock` - Update stock levels

### Task 2: Identify how services communicate

**Example Bob Prompts:**
- "How do the order and payment services communicate? Show me both synchronous and asynchronous patterns"
- "Explain the event-driven architecture and Kafka topic usage"

**Expected Answer:**

**Synchronous Communication (REST):**
- Order Service → Payment Service: Direct REST calls for payment processing
- Order Service → Inventory Service: REST calls for stock checks and reservations
- All external traffic → API Gateway → Services

**Asynchronous Communication (Kafka):**
- Order Service publishes: `order-created`, `order-validated`, `order-confirmed`
- Payment Service publishes: `payment-initiated`, `payment-completed`, `payment-failed`
- Inventory Service publishes: `stock-reserved`, `stock-released`, `stock-updated`
- Services consume events from topics they're interested in

### Task 3: Locate Kafka topic configurations

**Example Bob Prompts:**
- "Where are Kafka topics configured? Show me the topic names and their settings"
- "Find all Kafka topic definitions and consumer group configurations"

**Expected Findings:**
- **File:** `kafka/topics-config.yml`
- **Topics:** `order-events`, `payment-events`, `inventory-events`
- **Consumer Groups:** Defined in `kafka/consumer-groups.md`
- **Message Schemas:** Located in `kafka/message-schemas/`

### Task 4: Find payment timeout configurations

**Example Bob Prompts:**
- "Where are payment timeouts configured in the payment service?"
- "Show me all timeout settings related to payment processing"

**Expected Findings:**
- **Application Config:** `payment-service/src/main/resources/application.yml`
  - `payment.gateway.timeout: 5000ms` (default)
  - `payment.gateway.connect-timeout: 2000ms`
- **Production Override:** `application-prod.yml` may have different values
- **API Gateway:** `api-gateway/routes.yml` may have upstream timeouts

---

## Exercise 2: Log Analysis & Troubleshooting

### Task 1: Analyze payment service logs for timeout patterns

**Example Bob Prompts:**
- "Analyze payment-service-debug.log and identify why payments are timing out"
- "What patterns do you see in the payment timeout errors?"

**Expected Analysis:**

**Key Findings:**
1. **Timeout Pattern:** Payments consistently timing out after 5 seconds
2. **External API Latency:** StripeConnect API calls taking 8-12 seconds
3. **Database Connection Pool:** Evidence of connection pool exhaustion
4. **Correlation:** Timeouts spike during high traffic periods

**Root Cause Indicators:**
```
ERROR PaymentProcessor - Payment timeout for order ORD-2024-03-15-7891
ERROR PaymentProcessor - StripeConnect API call exceeded timeout: 5000ms
WARN HikariPool - Connection pool exhausted, waiting for available connection
ERROR PaymentProcessor - Database query timeout after 5000ms
```

**Recommended Solutions:**
1. Increase timeout from 5s to 10s (short-term)
2. Implement circuit breaker pattern
3. Add connection pool monitoring
4. Investigate StripeConnect API performance
5. Consider async payment processing

### Task 2: Trace a failed order using correlation IDs

**Example Bob Prompts:**
- "Trace order ID ORD-2024-03-15-7891 across all service logs"
- "Show me the complete flow of order ORD-2024-03-15-7891 from creation to failure"

**Expected Trace:**

```
1. [order-service] 09:23:15 - Order created: ORD-2024-03-15-7891
2. [order-service] 09:23:16 - Inventory check initiated
3. [inventory-service] 09:23:16 - Stock reserved for order ORD-2024-03-15-7891
4. [order-service] 09:23:17 - Payment processing initiated
5. [payment-service] 09:23:17 - Payment request received for ORD-2024-03-15-7891
6. [payment-service] 09:23:22 - StripeConnect API timeout
7. [payment-service] 09:23:22 - Payment failed: TIMEOUT
8. [order-service] 09:23:23 - Order status updated: PAYMENT_FAILED
9. [kafka] 09:23:23 - Event published: payment-failed
```

### Task 3: Identify the cause of Kafka consumer lag

**Example Bob Prompts:**
- "What's causing the Kafka consumer lag in the order service?"
- "Analyze kafka-consumer.log and explain why messages are backing up"

**Expected Analysis:**

**Key Findings:**
1. **Consumer Lag:** 45,000-60,000 messages behind
2. **Processing Rate:** Only 500 msg/sec (normal: 1,200 msg/sec)
3. **Slow Database Queries:** Consumer threads blocked on DB operations
4. **Rebalancing:** Frequent consumer group rebalancing

**Root Cause:**
```
WARN KafkaConsumer - Consumer lag: 52,341 messages
ERROR OrderEventConsumer - Message processing took 2,450ms (threshold: 100ms)
WARN OrderRepository - Slow query detected: SELECT * FROM orders WHERE... (1,850ms)
INFO ConsumerCoordinator - Rebalancing consumer group order-consumer-group
```

**Recommended Solutions:**
1. Optimize database queries (add indexes)
2. Increase consumer instances (scale horizontally)
3. Implement batch processing
4. Add database connection pooling
5. Consider read replicas for queries

### Task 4: Find evidence of memory leak in order-service logs

**Example Bob Prompts:**
- "Find patterns in order-service-error.log that suggest a memory leak"
- "Analyze memory-related errors in the order service"

**Expected Findings:**

**Memory Leak Indicators:**
```
WARN JVM - Heap memory usage: 85% (6.8GB of 8GB)
ERROR OrderService - OutOfMemoryError: Java heap space
WARN GC - Full GC took 1,245ms (pause time increasing)
ERROR OrderCache - Cache size: 1,250,000 entries (expected: ~10,000)
WARN JVM - Heap memory usage: 92% (7.4GB of 8GB)
ERROR Kubernetes - Pod order-service-7d9f8b-xyz OOMKilled
```

**Root Cause:**
- Order caching mechanism not releasing old entries
- WeakHashMap not working as expected
- Cache growing unbounded during high traffic

**Recommended Solutions:**
1. Implement proper cache eviction policy (LRU, TTL)
2. Use Caffeine or Guava cache with size limits
3. Add cache monitoring and metrics
4. Review object retention in heap dumps
5. Consider external cache (Redis)

---

## Exercise 3: Documentation Synthesis

### Task 1: Create a complete data flow diagram for order processing

**Example Bob Prompts:**
- "Create a data flow diagram showing how an order flows through the system from creation to completion"
- "Document the complete order processing flow including all services and events"

**Expected Diagram (Text Format):**

```
Order Processing Flow:

1. Client Request
   ↓
2. API Gateway (Kong)
   ↓
3. Order Service
   ├─→ Validate Order Data
   ├─→ Check Inventory (REST → Inventory Service)
   │   └─→ Reserve Stock
   ├─→ Publish: order-created (Kafka)
   └─→ Initiate Payment (REST → Payment Service)
       ├─→ Fraud Detection
       ├─→ StripeConnect API Call
       ├─→ Publish: payment-completed (Kafka)
       └─→ Return Payment Status
   ↓
4. Order Service (on payment-completed event)
   ├─→ Update Order Status: CONFIRMED
   ├─→ Publish: order-confirmed (Kafka)
   └─→ Return Order Confirmation to Client
   ↓
5. Downstream Consumers
   ├─→ Shipping Service (consumes order-confirmed)
   ├─→ Analytics Service (consumes all events)
   └─→ Notification Service (consumes order-confirmed)
```

### Task 2: Document missing pieces in deployment procedure

**Example Bob Prompts:**
- "What information is missing from the deployment procedure in docs/runbooks/deployment-procedure.md?"
- "Review the deployment runbook and identify gaps"

**Expected Gaps:**

1. **Pre-deployment Checklist:**
   - Database migration verification steps
   - Dependency version compatibility checks
   - Feature flag configuration

2. **Deployment Steps:**
   - Specific kubectl commands for each service
   - Health check verification procedures
   - Rollback trigger criteria

3. **Post-deployment:**
   - Smoke test procedures
   - Monitoring dashboard links
   - Success criteria metrics

4. **Emergency Procedures:**
   - Rollback commands
   - Incident escalation contacts
   - Communication templates

### Task 3: Identify conflicts between documentation and code

**Example Bob Prompts:**
- "Are there any conflicts between the architecture docs and the actual code implementation?"
- "Compare the API documentation with the actual REST endpoints"

**Expected Conflicts:**

1. **API Versioning:**
   - Docs say: API version v2
   - Code implements: v1 endpoints only

2. **Timeout Values:**
   - Architecture doc: 10s timeout
   - Actual config: 5s timeout

3. **Kafka Topics:**
   - Docs mention: `order-status-updates` topic
   - Code uses: `order-events` topic

4. **Database Schema:**
   - ERD shows `customer_id` as UUID
   - Code uses `customer_id` as Long

### Task 4: Generate an API integration guide

**Example Bob Prompts:**
- "Generate an API integration guide for external clients wanting to integrate with our order system"
- "Create documentation for third-party developers to use our APIs"

**Expected Guide Structure:**

```markdown
# Order API Integration Guide

## Authentication
- API Key required in header: `X-API-Key`
- Rate limit: 1000 requests/hour

## Creating an Order

POST /api/orders
Content-Type: application/json

{
  "customerId": "CUST-12345",
  "items": [
    {
      "productId": "PROD-789",
      "quantity": 2,
      "price": 29.99
    }
  ],
  "shippingAddress": { ... }
}

Response: 201 Created
{
  "orderId": "ORD-2024-03-15-7891",
  "status": "CREATED",
  "totalAmount": 59.98
}

## Error Handling
- 400: Invalid request data
- 401: Authentication failed
- 429: Rate limit exceeded
- 500: Internal server error

## Webhooks
Subscribe to order status updates:
- order.created
- order.confirmed
- order.shipped
- order.delivered
```

---

## Exercise 4: Incident Response

### Task 1: Complete the postmortem for INC-2024-001 (payment timeout)

**Example Bob Prompts:**
- "Complete the postmortem for the payment timeout incident INC-2024-001"
- "Draft a comprehensive incident report for the payment service timeouts"

**Expected Postmortem:**

```markdown
# Incident Postmortem: INC-2024-001 - Payment Timeout Crisis

## Summary
On March 15, 2024, 15% of payment requests experienced timeouts, resulting in order failures and approximately $180,000/hour in lost revenue.

## Impact
- Duration: 2 hours 15 minutes
- Affected Transactions: ~13,500 payments
- Revenue Impact: $405,000 in lost sales
- Customer Impact: 300% increase in support tickets

## Root Cause
1. **Primary:** StripeConnect API degradation (8-12s response times vs normal 1-2s)
2. **Contributing:** Payment service timeout set too low (5s)
3. **Contributing:** No circuit breaker to fail fast
4. **Contributing:** Database connection pool exhaustion under retry load

## Timeline
- 09:23 UTC: First alerts for elevated payment latency
- 09:45 UTC: Timeout rate reaches 10%
- 10:15 UTC: Engineering team paged
- 10:30 UTC: Timeout rate peaks at 18%
- 11:00 UTC: Mitigation: Increased timeout to 10s
- 11:38 UTC: StripeConnect performance recovered
- 11:45 UTC: Incident resolved

## What Went Well
- Monitoring detected issue within 2 minutes
- Team responded quickly
- Mitigation applied within 45 minutes

## What Went Wrong
- No circuit breaker to prevent cascade failures
- Timeout configuration too aggressive
- No fallback payment provider
- Insufficient load testing with external API delays

## Action Items
1. [P0] Implement circuit breaker pattern (Owner: Sarah, Due: Mar 20)
2. [P0] Increase timeout to 10s with exponential backoff (Owner: Marcus, Due: Mar 18)
3. [P1] Add fallback payment provider (Owner: Emily, Due: Mar 30)
4. [P1] Implement connection pool monitoring (Owner: Sarah, Due: Mar 22)
5. [P2] Load test with simulated API delays (Owner: QA Team, Due: Apr 5)
6. [P2] Add payment service SLO dashboard (Owner: Marcus, Due: Mar 25)
```

### Task 2: Draft an incident report for Kafka lag issue

**Example Bob Prompts:**
- "Draft an incident report for the Kafka consumer lag issue"
- "Create an incident report for INC-2024-002 following the template"

**Expected Report:**

```markdown
# Incident Report: INC-2024-002 - Kafka Consumer Lag

## Incident Details
- **ID:** INC-2024-002
- **Severity:** P1 - Critical
- **Detected:** March 14, 2024, 14:00 UTC
- **Resolved:** March 14, 2024, 18:30 UTC
- **Duration:** 4 hours 30 minutes

## Impact
- Order processing delayed by 5-10 minutes
- 50,000+ messages backed up in queue
- Customer confusion about order status
- 150% increase in support tickets

## Root Cause
Slow database queries in order event consumer blocking message processing threads.

## Technical Details
- Consumer lag grew from <100 to 60,000 messages
- Processing rate dropped from 1,200 to 500 msg/sec
- Database queries taking 1,500-2,000ms (normal: 50ms)
- Missing database index on orders.correlation_id column

## Resolution
1. Added database index on correlation_id column
2. Scaled consumer instances from 3 to 6
3. Implemented batch processing for events
4. Consumer lag cleared within 2 hours

## Preventive Measures
1. Add database query performance monitoring
2. Implement consumer lag alerting (threshold: 1,000 messages)
3. Regular database index review
4. Load testing for event processing
```

### Task 3: Propose architectural changes

**Example Bob Prompts:**
- "What architectural changes would prevent these types of incidents in the future?"
- "Recommend system improvements to increase resilience"

**Expected Recommendations:**

```markdown
# Architectural Improvements

## 1. Resilience Patterns
- **Circuit Breaker:** Implement for all external API calls
- **Bulkhead:** Isolate thread pools for different operations
- **Retry with Backoff:** Exponential backoff for transient failures
- **Timeout Strategy:** Tiered timeouts (connect, read, total)

## 2. Observability Enhancements
- **Distributed Tracing:** Full request tracing across services
- **SLO Dashboards:** Service-level objective monitoring
- **Predictive Alerting:** ML-based anomaly detection
- **Correlation ID Propagation:** Consistent across all services

## 3. Scalability Improvements
- **Auto-scaling:** Based on queue depth and CPU
- **Read Replicas:** For read-heavy database operations
- **Caching Layer:** Redis for frequently accessed data
- **Event Sourcing:** For order state management

## 4. Reliability Measures
- **Chaos Engineering:** Regular failure injection testing
- **Load Testing:** Continuous performance testing
- **Canary Deployments:** Gradual rollout with monitoring
- **Feature Flags:** Quick rollback capability

## 5. Data Management
- **Database Indexing:** Regular index optimization
- **Query Optimization:** Slow query monitoring and tuning
- **Connection Pooling:** Proper sizing and monitoring
- **Data Archival:** Move old data to cold storage
```

### Task 4: Create action items with owners and timelines

**Example Bob Prompts:**
- "Create a prioritized action item list with owners and deadlines"
- "Generate a remediation plan with specific tasks and assignments"

**Expected Action Plan:**

```markdown
# Remediation Action Plan

## Immediate (This Week)
- [ ] [P0] Implement circuit breaker for payment service (Sarah Chen, Mar 18)
- [ ] [P0] Increase payment timeout to 10s (Marcus Rodriguez, Mar 17)
- [ ] [P0] Add database index for order queries (Marcus Rodriguez, Mar 17)
- [ ] [P0] Scale Kafka consumers to 6 instances (Sarah Chen, Mar 18)

## Short-term (Next 2 Weeks)
- [ ] [P1] Implement connection pool monitoring (Sarah Chen, Mar 22)
- [ ] [P1] Add consumer lag alerting (Marcus Rodriguez, Mar 25)
- [ ] [P1] Fix order service memory leak (Emily Watson, Mar 28)
- [ ] [P1] Implement proper cache eviction (Emily Watson, Mar 28)
- [ ] [P1] Add distributed tracing (Sarah Chen, Mar 30)

## Medium-term (Next Month)
- [ ] [P2] Implement fallback payment provider (Emily Watson, Apr 15)
- [ ] [P2] Add read replicas for databases (Marcus Rodriguez, Apr 10)
- [ ] [P2] Implement Redis caching layer (Sarah Chen, Apr 20)
- [ ] [P2] Create SLO dashboards (Marcus Rodriguez, Apr 12)
- [ ] [P2] Load testing with API delays (QA Team, Apr 5)

## Long-term (Next Quarter)
- [ ] [P3] Implement event sourcing (Emily Watson, May 30)
- [ ] [P3] Set up chaos engineering (Sarah Chen, Jun 15)
- [ ] [P3] Implement canary deployments (Marcus Rodriguez, Jun 30)
- [ ] [P3] Database query optimization review (DBA Team, May 15)
```

---

## Exercise 5: Code Review & Reasoning

### Task 1: Review error handling in payment service

**Example Bob Prompts:**
- "Review the error handling in PaymentProcessor.java - what could be improved?"
- "Analyze the payment service error handling and suggest improvements"

**Expected Analysis:**

**Current Issues:**
1. **Generic Exception Catching:** Catches `Exception` instead of specific types
2. **No Retry Logic:** Fails immediately on transient errors
3. **Poor Error Messages:** Generic messages don't help debugging
4. **No Circuit Breaker:** Continues calling failing external API
5. **Missing Logging Context:** Doesn't log correlation IDs

**Recommended Improvements:**
```java
// Before
try {
    paymentGateway.process(payment);
} catch (Exception e) {
    throw new PaymentException("Payment failed");
}

// After
try {
    return circuitBreaker.executeSupplier(() -> {
        return retryTemplate.execute(context -> {
            logger.info("Processing payment {} (attempt {})", 
                payment.getId(), context.getRetryCount());
            return paymentGateway.process(payment);
        });
    });
} catch (PaymentGatewayException e) {
    logger.error("Payment gateway error for payment {}: {}", 
        payment.getId(), e.getMessage(), e);
    throw new PaymentProcessingException(
        "Payment gateway unavailable", e);
} catch (TimeoutException e) {
    logger.error("Payment timeout for payment {}", payment.getId(), e);
    throw new PaymentTimeoutException(
        "Payment processing timed out", e);
}
```

### Task 2: Evaluate fraud detection logic

**Example Bob Prompts:**
- "Analyze the fraud detection logic in FraudDetection.java - are there any edge cases?"
- "Review the fraud detection rules and identify potential issues"

**Expected Analysis:**

**Potential Issues:**
1. **Amount Threshold:** Fixed $10,000 threshold may be too high/low
2. **Velocity Checks:** Doesn't account for legitimate bulk purchases
3. **Geographic Rules:** May block legitimate international customers
4. **Time-based Rules:** Doesn't consider time zones
5. **False Positives:** No mechanism to learn from false positives

**Edge Cases:**
- Multiple small transactions just under threshold
- Legitimate business customers with high volumes
- Customers traveling internationally
- Shared IP addresses (corporate networks, VPNs)
- Legitimate rush orders during sales events

**Recommended Improvements:**
- Implement machine learning-based scoring
- Add customer behavior profiling
- Implement whitelist for known good customers
- Add manual review queue for borderline cases
- Track and learn from false positives

### Task 3: Assess order service's event publishing mechanism

**Example Bob Prompts:**
- "Is the order service's event publishing mechanism reliable?"
- "Review how the order service publishes events to Kafka and identify risks"

**Expected Analysis:**

**Current Implementation Risks:**
1. **No Transactional Outbox:** Events published before database commit
2. **Potential Duplicate Events:** No idempotency guarantees
3. **Event Ordering:** No guarantee of order for related events
4. **Failure Handling:** Events lost if Kafka is unavailable
5. **No Dead Letter Queue:** Failed events are dropped

**Reliability Issues:**
```java
// Risky: Event published before DB commit
orderRepository.save(order);
kafkaTemplate.send("order-events", orderEvent); // May fail
// If this fails, order is saved but event not published
```

**Recommended Pattern:**
```java
// Transactional Outbox Pattern
@Transactional
public void createOrder(Order order) {
    orderRepository.save(order);
    outboxRepository.save(new OutboxEvent(
        "order-created", 
        order.getId(), 
        serializeOrder(order)
    ));
}

// Separate process polls outbox and publishes to Kafka
// Ensures at-least-once delivery
```

### Task 4: Identify potential race conditions

**Example Bob Prompts:**
- "Are there any potential race conditions in the inventory reservation code?"
- "Review the inventory service for concurrency issues"

**Expected Analysis:**

**Race Condition in Stock Reservation:**
```java
// PROBLEM: Check-then-act race condition
public boolean reserveStock(String productId, int quantity) {
    int available = getAvailableStock(productId); // Read
    if (available >= quantity) {
        updateStock(productId, available - quantity); // Write
        return true;
    }
    return false;
}
// Two concurrent requests can both pass the check
// and over-reserve inventory
```

**Recommended Solutions:**

**Option 1: Optimistic Locking**
```java
@Version
private Long version;

public boolean reserveStock(String productId, int quantity) {
    try {
        Product product = productRepository.findById(productId);
        if (product.getStock() >= quantity) {
            product.setStock(product.getStock() - quantity);
            productRepository.save(product); // Throws if version changed
            return true;
        }
    } catch (OptimisticLockException e) {
        // Retry or fail
    }
    return false;
}
```

**Option 2: Database-level Atomic Update**
```sql
UPDATE products 
SET stock = stock - :quantity 
WHERE product_id = :productId 
  AND stock >= :quantity
RETURNING stock;
```

**Option 3: Distributed Lock**
```java
public boolean reserveStock(String productId, int quantity) {
    RLock lock = redisson.getLock("product:" + productId);
    try {
        lock.lock(5, TimeUnit.SECONDS);
        // Perform reservation
    } finally {
        lock.unlock();
    }
}
```

---

## Additional Tips

### Effective Bob Usage
1. **Start with broad questions** to understand context
2. **Ask follow-up questions** to drill into specifics
3. **Request multiple approaches** for complex problems
4. **Verify assumptions** by cross-referencing files
5. **Use Bob to explain** unfamiliar code patterns

### Common Patterns to Look For
- Configuration mismatches between environments
- Missing error handling in critical paths
- Lack of observability (logging, metrics, tracing)
- Synchronous calls that should be asynchronous
- Missing retry logic for transient failures
- Inadequate timeout configurations
- Race conditions in concurrent code
- Memory leaks from unbounded caches

### Documentation Best Practices
- Include diagrams for complex flows
- Document assumptions and trade-offs
- Provide runnable examples
- Keep documentation close to code
- Version documentation with code changes
- Include troubleshooting guides
- Document known limitations

---

**Remember:** These solutions are starting points. Real-world scenarios often require adaptations based on specific constraints, team preferences, and business requirements. Use Bob to explore alternatives and validate your approach!