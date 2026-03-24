# Order Service

The Order Service is responsible for managing the complete order lifecycle in the TechMart e-commerce platform.

## Overview

This microservice handles:
- Order creation and validation
- Order status management
- Order lifecycle transitions
- Event publishing to Kafka
- Integration with payment and inventory services

## Architecture

### Technology Stack
- **Java**: 17
- **Spring Boot**: 3.1.5
- **Database**: PostgreSQL 15
- **Message Broker**: Apache Kafka 3.5
- **Build Tool**: Maven

### Key Components

1. **OrderController**: REST API endpoints for order operations
2. **OrderService**: Business logic and orchestration
3. **OrderRepository**: Data access layer
4. **Order/OrderItem**: Domain entities

## API Endpoints

### Order Management

- `POST /api/v1/orders` - Create a new order
- `GET /api/v1/orders/{id}` - Get order by ID
- `GET /api/v1/orders/by-number/{orderNumber}` - Get order by order number
- `PUT /api/v1/orders/{id}/status` - Update order status
- `POST /api/v1/orders/{id}/validate` - Validate an order
- `POST /api/v1/orders/{id}/confirm` - Confirm order after payment

### Query Endpoints

- `GET /api/v1/orders/customer/{customerId}` - Get orders by customer
- `GET /api/v1/orders/status/{status}` - Get orders by status

### Monitoring

- `GET /api/v1/orders/health` - Health check
- `GET /api/v1/orders/cache-stats` - Cache statistics (debugging)

## Order Lifecycle

```
CREATED → VALIDATED → CONFIRMED → SHIPPED → DELIVERED
   ↓          ↓           ↓          ↓
        CANCELLED (from any state except DELIVERED)
```

### Status Transitions

1. **CREATED**: Order is created but not yet validated
2. **VALIDATED**: Inventory checked, customer verified
3. **CONFIRMED**: Payment completed, ready for fulfillment
4. **SHIPPED**: Order dispatched to customer
5. **DELIVERED**: Order received by customer
6. **CANCELLED**: Order cancelled (cannot cancel after delivery)

## Events Published

The service publishes events to the `order-events` Kafka topic:

- `order-created`: When a new order is created
- `order-validated`: When order passes validation
- `order-confirmed`: When payment is completed
- `order-status-changed`: When order status changes

### Event Schema

```json
{
  "eventType": "order-created",
  "orderId": "uuid",
  "orderNumber": "ORD-2024-03-15-1234",
  "customerId": "uuid",
  "status": "CREATED",
  "totalAmount": 150.00,
  "correlationId": "uuid",
  "timestamp": "2024-03-15T10:30:00"
}
```

## Configuration

### Database Configuration

```yaml
spring:
  datasource:
    url: jdbc:postgresql://localhost:5432/orders_db
    username: orders_user
    password: orders_pass
```

### Kafka Configuration

```yaml
spring:
  kafka:
    bootstrap-servers: localhost:9092
    producer:
      acks: all
      retries: 3
```

## Known Issues

### Memory Leak (INC-2024-003)

**Status**: Under investigation  
**Severity**: P2 - High  
**Impact**: Service restarts every 4-6 hours

The order caching mechanism has a memory leak. The combination of `WeakHashMap` and `ConcurrentHashMap` prevents proper garbage collection:

```java
// MEMORY LEAK: This cache grows unbounded
private final Map<String, Order> orderCache = new WeakHashMap<>();
private final Map<String, String> orderNumberToIdCache = new ConcurrentHashMap<>();
```

**Workaround**: Restart service every 4 hours  
**Fix**: Planned for v3.2.0

### Slow Validation Queries

**Status**: Identified  
**Severity**: P1 - Critical  
**Impact**: Kafka consumer lag

Database queries in `performValidationChecks()` are slow due to missing index on `customer_id`. This blocks Kafka consumer threads, causing lag.

**Workaround**: Increased consumer timeout  
**Fix**: Add database index (scheduled for next maintenance window)

## Running Locally

### Prerequisites

- Java 17
- Maven 3.8+
- PostgreSQL 15
- Kafka 3.5

### Start Dependencies

```bash
# Start PostgreSQL
docker run -d --name postgres \
  -e POSTGRES_DB=orders_db \
  -e POSTGRES_USER=orders_user \
  -e POSTGRES_PASSWORD=orders_pass \
  -p 5432:5432 postgres:15

# Start Kafka
docker run -d --name kafka \
  -p 9092:9092 \
  apache/kafka:3.5.0
```

### Build and Run

```bash
# Build
mvn clean package

# Run
mvn spring-boot:run

# Or run with production profile
mvn spring-boot:run -Dspring-boot.run.profiles=prod
```

### Run Tests

```bash
mvn test
```

## Monitoring

### Metrics

Prometheus metrics available at: `http://localhost:8081/actuator/prometheus`

Key metrics:
- `order_created_total`: Total orders created
- `order_validation_duration_seconds`: Validation time
- `order_cache_size`: Current cache size

### Health Check

```bash
curl http://localhost:8081/api/v1/orders/health
```

### Logs

Logs are written to:
- Console: Structured JSON format
- File: `logs/order-service.log`

Log pattern includes correlation ID for distributed tracing:
```
2024-03-15 10:30:00.123 [http-nio-8081-exec-1] INFO  OrderController [abc-123-def] - Creating order
```

## Troubleshooting

### High Memory Usage

Check cache statistics:
```bash
curl http://localhost:8081/api/v1/orders/cache-stats
```

If cache size is growing unbounded, restart the service.

### Kafka Consumer Lag

Check consumer lag:
```bash
kafka-consumer-groups --bootstrap-server localhost:9092 \
  --group order-service-group --describe
```

If lag is high, check database query performance.

### Database Connection Issues

Verify connection pool settings in `application.yml`:
```yaml
spring:
  datasource:
    hikari:
      maximum-pool-size: 20
      connection-timeout: 30000
```

## Development

### Code Structure

```
src/main/java/com/enterprise/orders/
├── model/
│   ├── Order.java
│   ├── OrderItem.java
│   └── OrderStatus.java
├── OrderController.java
├── OrderService.java
├── OrderRepository.java
├── OrderServiceException.java
└── OrderNotFoundException.java
```

### Adding New Features

1. Add business logic to `OrderService`
2. Add REST endpoint to `OrderController`
3. Update event publishing if needed
4. Add tests
5. Update API documentation

## Related Services

- **Payment Service**: Processes payments for orders
- **Inventory Service**: Manages product stock
- **API Gateway**: Routes external requests

## Support

For issues or questions:
- Check logs: `logs/order-service.log`
- Review incidents: `../incidents/`
- Contact: platform-team@techmart.com