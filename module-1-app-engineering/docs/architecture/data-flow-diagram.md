# Data Flow Diagram

## Order Processing Flow

1. Customer submits order via API Gateway
2. API Gateway routes to Order Service
3. Order Service creates order (status: CREATED)
4. Order Service publishes "order-created" event to Kafka
5. Order Service validates order (inventory check)
6. Order Service updates status to VALIDATED
7. Payment Service processes payment
8. Payment Service publishes "payment-completed" event
9. Order Service receives payment event
10. Order Service confirms order (status: CONFIRMED)
11. Inventory Service reserves stock
12. Order moves to fulfillment

## Event Flow

```
Order Service -> Kafka (order-events) -> Payment Service
Payment Service -> Kafka (payment-events) -> Order Service
Order Service -> Kafka (order-events) -> Inventory Service
```

## Data Stores

- Each service has its own PostgreSQL database
- No shared databases (microservices pattern)
- Event sourcing for audit trail
