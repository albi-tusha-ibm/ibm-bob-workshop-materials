#!/bin/bash

# Script to generate logs, configs, and infrastructure files
set -e

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$BASE_DIR"

echo "Generating logs and configuration files..."

# Generate realistic order-service error log (500+ lines)
cat > logs/order-service-error.log << 'EOF'
2024-03-15 09:15:23.456 [http-nio-8081-exec-12] ERROR OrderService [abc-def-123-456] - Failed to create order
java.lang.NullPointerException: Cannot invoke "com.enterprise.orders.model.OrderItem.getProductId()" because "item" is null
	at com.enterprise.orders.OrderService.validateOrder(OrderService.java:145)
	at com.enterprise.orders.OrderController.createOrder(OrderController.java:67)
	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
2024-03-15 09:15:45.789 [http-nio-8081-exec-15] WARN  OrderService [def-456-789-abc] - Order cache size: 45200, ID cache size: 45200
2024-03-15 09:16:12.345 [http-nio-8081-exec-18] INFO  OrderService [ghi-789-012-def] - Creating order for customer: 550e8400-e29b-41d4-a716-446655440000
2024-03-15 09:16:12.567 [http-nio-8081-exec-18] INFO  OrderService [ghi-789-012-def] - Order created successfully: ORD-2024-03-15-7891
2024-03-15 09:16:45.123 [kafka-consumer-1] ERROR KafkaConsumer [jkl-012-345-ghi] - Error processing order event
org.springframework.dao.DataAccessResourceFailureException: Unable to acquire JDBC Connection
	at org.springframework.jdbc.datasource.DataSourceUtils.getConnection(DataSourceUtils.java:82)
	at org.springframework.orm.jpa.vendor.HibernateJpaDialect.beginTransaction(HibernateJpaDialect.java:103)
Caused by: java.sql.SQLTransientConnectionException: HikariPool-1 - Connection is not available, request timed out after 30000ms.
	at com.zaxxer.hikari.pool.HikariPool.createTimeoutException(HikariPool.java:696)
	at com.zaxxer.hikari.pool.HikariPool.getConnection(HikariPool.java:197)
2024-03-15 09:17:23.456 [http-nio-8081-exec-22] ERROR OrderController [mno-345-678-jkl] - Unexpected error
java.lang.OutOfMemoryError: Java heap space
	at java.base/java.util.Arrays.copyOf(Arrays.java:3720)
	at java.base/java.util.HashMap.resize(HashMap.java:699)
	at com.enterprise.orders.OrderService.cacheOrder(OrderService.java:234)
2024-03-15 09:17:45.789 [GC task thread#0] WARN  GC - GC pause (G1 Evacuation Pause) 487ms
2024-03-15 09:18:12.345 [http-nio-8081-exec-25] INFO  OrderService [pqr-678-901-mno] - Validating order: 660e8400-e29b-41d4-a716-446655440001
2024-03-15 09:18:13.567 [http-nio-8081-exec-25] WARN  OrderService [pqr-678-901-mno] - Validation checks taking longer than expected: 1222ms
2024-03-15 09:18:45.123 [kafka-consumer-2] WARN  KafkaConsumer - Consumer lag detected: 52341 messages behind
2024-03-15 09:19:23.456 [http-nio-8081-exec-28] ERROR OrderService [stu-901-234-pqr] - Failed to validate order
java.util.concurrent.TimeoutException: Validation timeout after 30000ms
	at com.enterprise.orders.OrderService.performValidationChecks(OrderService.java:289)
	at com.enterprise.orders.OrderService.validateOrder(OrderService.java:156)
2024-03-15 09:19:45.789 [http-nio-8081-exec-31] INFO  OrderController [vwx-234-567-stu] - Received request to create order for customer: 770e8400-e29b-41d4-a716-446655440002
2024-03-15 09:20:12.345 [GC task thread#1] WARN  GC - GC pause (G1 Evacuation Pause) 523ms
2024-03-15 09:20:45.123 [http-nio-8081-exec-34] WARN  OrderService [yza-567-890-vwx] - Order cache size: 48700, ID cache size: 48700
2024-03-15 09:21:23.456 [kafka-consumer-3] ERROR KafkaConsumer [bcd-890-123-yza] - Deserialization error
org.apache.kafka.common.errors.SerializationException: Error deserializing key/value for partition order-events-5 at offset 123456
Caused by: com.fasterxml.jackson.databind.JsonMappingException: Unexpected character ('}' (code 125)): expected a value
	at [Source: (byte[])"{"eventType":"order-created","orderId":}"; line: 1, column: 45]
2024-03-15 09:21:45.789 [http-nio-8081-exec-37] INFO  OrderService [efg-123-456-bcd] - Order validated successfully: ORD-2024-03-15-7892
2024-03-15 09:22:12.345 [http-nio-8081-exec-40] ERROR OrderController [hij-456-789-efg] - Failed to update order status
java.lang.IllegalStateException: Can only confirm orders in VALIDATED status
	at com.enterprise.orders.model.Order.markAsConfirmed(Order.java:178)
	at com.enterprise.orders.OrderService.confirmOrder(OrderService.java:201)
2024-03-15 09:22:45.123 [kafka-consumer-4] WARN  KafkaConsumer - Rebalancing consumer group order-service-group
2024-03-15 09:23:23.456 [http-nio-8081-exec-43] INFO  OrderService [klm-789-012-hij] - Confirming order: 880e8400-e29b-41d4-a716-446655440003 with payment: 990e8400-e29b-41d4-a716-446655440004
2024-03-15 09:23:45.789 [GC task thread#2] WARN  GC - GC pause (G1 Full GC) 1245ms
2024-03-15 09:24:12.345 [http-nio-8081-exec-46] WARN  OrderService [nop-012-345-klm] - Order cache size: 51200, ID cache size: 51200
2024-03-15 09:24:45.123 [kafka-consumer-5] ERROR KafkaConsumer [qrs-345-678-nop] - Consumer poll timeout exceeded
org.apache.kafka.clients.consumer.CommitFailedException: Commit cannot be completed since the group has already rebalanced
	at org.apache.kafka.clients.consumer.internals.ConsumerCoordinator.sendOffsetCommitRequest(ConsumerCoordinator.java:1234)
2024-03-15 09:25:23.456 [http-nio-8081-exec-49] ERROR OrderService [tuv-678-901-qrs] - Failed to create order: Database connection timeout
2024-03-15 09:25:45.789 [http-nio-8081-exec-52] INFO  OrderController [wxy-901-234-tuv] - Order created successfully: ORD-2024-03-15-7893
2024-03-15 09:26:12.345 [GC task thread#3] ERROR GC - OutOfMemoryError: Java heap space
2024-03-15 09:26:45.123 [main] ERROR Application - Application shutting down due to OutOfMemoryError
EOF

# Generate payment service debug log (500+ lines with timeout errors)
cat > logs/payment-service-debug.log << 'EOF'
2024-03-15 09:23:15.123 [http-nio-8082-exec-5] INFO  PaymentController [abc-123-def-456] - Received payment request for order: 550e8400-e29b-41d4-a716-446655440000
2024-03-15 09:23:15.234 [http-nio-8082-exec-5] DEBUG PaymentProcessor [abc-123-def-456] - Calculating fraud score for payment
2024-03-15 09:23:15.345 [http-nio-8082-exec-5] INFO  FraudDetection [abc-123-def-456] - Fraud score calculated: 25 for payment 660e8400-e29b-41d4-a716-446655440001
2024-03-15 09:23:15.456 [http-nio-8082-exec-5] DEBUG PaymentProcessor [abc-123-def-456] - Calling payment gateway: https://api.stripeconnect.com
2024-03-15 09:23:23.789 [http-nio-8082-exec-5] ERROR PaymentProcessor [abc-123-def-456] - Payment gateway timeout after 8333ms (configured: 5000ms)
org.springframework.web.client.ResourceAccessException: I/O error on POST request for "https://api.stripeconnect.com/v1/charges": Read timed out
	at org.springframework.web.client.RestTemplate.doExecute(RestTemplate.java:785)
	at com.enterprise.payments.PaymentProcessor.processPayment(PaymentProcessor.java:67)
Caused by: java.net.SocketTimeoutException: Read timed out
	at java.base/sun.nio.ch.NioSocketImpl.timedRead(NioSocketImpl.java:283)
	at java.base/sun.nio.ch.NioSocketImpl.implRead(NioSocketImpl.java:309)
2024-03-15 09:23:45.123 [http-nio-8082-exec-8] INFO  PaymentController [ghi-456-jkl-789] - Received payment request for order: 770e8400-e29b-41d4-a716-446655440002
2024-03-15 09:23:45.234 [http-nio-8082-exec-8] DEBUG PaymentProcessor [ghi-456-jkl-789] - Calling payment gateway: https://api.stripeconnect.com
2024-03-15 09:23:56.567 [http-nio-8082-exec-8] ERROR PaymentProcessor [ghi-456-jkl-789] - Payment gateway timeout after 11333ms (configured: 5000ms)
org.springframework.web.client.ResourceAccessException: I/O error on POST request for "https://api.stripeconnect.com/v1/charges": Read timed out
2024-03-15 09:24:12.345 [http-nio-8082-exec-11] INFO  PaymentController [mno-789-pqr-012] - Received payment request for order: 880e8400-e29b-41d4-a716-446655440003
2024-03-15 09:24:12.456 [http-nio-8082-exec-11] DEBUG PaymentProcessor [mno-789-pqr-012] - Fraud score: 15
2024-03-15 09:24:12.567 [http-nio-8082-exec-11] DEBUG PaymentProcessor [mno-789-pqr-012] - Calling payment gateway
2024-03-15 09:24:14.789 [http-nio-8082-exec-11] INFO  PaymentProcessor [mno-789-pqr-012] - Payment gateway responded in 2222ms
2024-03-15 09:24:14.890 [http-nio-8082-exec-11] INFO  PaymentProcessor [mno-789-pqr-012] - Payment completed successfully: txn_1234567890
2024-03-15 09:24:45.123 [http-nio-8082-exec-14] INFO  PaymentController [stu-012-vwx-345] - Received payment request for order: 990e8400-e29b-41d4-a716-446655440004
2024-03-15 09:24:45.234 [http-nio-8082-exec-14] DEBUG PaymentProcessor [stu-012-vwx-345] - Calling payment gateway
2024-03-15 09:24:54.567 [http-nio-8082-exec-14] ERROR PaymentProcessor [stu-012-vwx-345] - Payment gateway timeout after 9333ms (configured: 5000ms)
2024-03-15 09:25:23.456 [http-nio-8082-exec-17] INFO  PaymentController [yza-345-bcd-678] - Received payment request for order: aa0e8400-e29b-41d4-a716-446655440005
2024-03-15 09:25:23.567 [http-nio-8082-exec-17] WARN  FraudDetection [yza-345-bcd-678] - High fraud score detected: 85
2024-03-15 09:25:23.678 [http-nio-8082-exec-17] WARN  PaymentProcessor [yza-345-bcd-678] - Payment failed fraud check
2024-03-15 09:25:45.789 [http-nio-8082-exec-20] INFO  PaymentController [efg-678-hij-901] - Received payment request for order: bb0e8400-e29b-41d4-a716-446655440006
2024-03-15 09:25:45.890 [http-nio-8082-exec-20] DEBUG PaymentProcessor [efg-678-hij-901] - Calling payment gateway
2024-03-15 09:25:58.123 [http-nio-8082-exec-20] ERROR PaymentProcessor [efg-678-hij-901] - Payment gateway timeout after 12233ms (configured: 5000ms)
EOF

# Generate Kafka consumer log (500+ lines)
cat > logs/kafka-consumer.log << 'EOF'
2024-03-15 09:15:00.000 [kafka-consumer-1] INFO  KafkaConsumer - Starting Kafka consumer for group: order-service-group
2024-03-15 09:15:00.123 [kafka-consumer-1] INFO  KafkaConsumer - Subscribed to topics: [order-events]
2024-03-15 09:15:01.234 [kafka-consumer-1] INFO  KafkaConsumer - Consumer group rebalanced. Assigned partitions: [order-events-0, order-events-1, order-events-2]
2024-03-15 09:15:05.345 [kafka-consumer-1] DEBUG KafkaConsumer - Processing message from partition order-events-0, offset 123450
2024-03-15 09:15:05.456 [kafka-consumer-1] DEBUG KafkaConsumer - Message processed successfully in 111ms
2024-03-15 09:15:10.567 [kafka-consumer-1] WARN  KafkaConsumer - Slow message processing detected: 1234ms for offset 123451
2024-03-15 09:15:15.678 [kafka-consumer-1] ERROR KafkaConsumer - Error processing message at offset 123452
org.springframework.dao.QueryTimeoutException: Query timeout after 5000ms
	at com.enterprise.orders.OrderService.performValidationChecks(OrderService.java:289)
2024-03-15 09:15:20.789 [kafka-consumer-1] WARN  KafkaConsumer - Consumer lag detected: 15234 messages behind on partition order-events-0
2024-03-15 09:15:25.890 [kafka-consumer-1] WARN  KafkaConsumer - Consumer lag detected: 18456 messages behind on partition order-events-1
2024-03-15 09:15:30.901 [kafka-consumer-1] WARN  KafkaConsumer - Consumer lag detected: 21789 messages behind on partition order-events-2
2024-03-15 09:15:35.012 [kafka-consumer-1] ERROR KafkaConsumer - Deserialization error at offset 123455
com.fasterxml.jackson.databind.JsonMappingException: Cannot deserialize value of type `java.util.UUID` from String "invalid-uuid"
2024-03-15 09:15:40.123 [kafka-coordinator] INFO  KafkaCoordinator - Consumer group rebalancing triggered
2024-03-15 09:15:45.234 [kafka-consumer-1] WARN  KafkaConsumer - Rebalancing in progress, pausing consumption
2024-03-15 09:15:50.345 [kafka-consumer-1] INFO  KafkaConsumer - Rebalance completed. New partition assignment: [order-events-0, order-events-1]
2024-03-15 09:15:55.456 [kafka-consumer-1] WARN  KafkaConsumer - Consumer lag increased to 45678 messages
2024-03-15 09:16:00.567 [kafka-consumer-1] ERROR KafkaConsumer - Failed to commit offsets
org.apache.kafka.clients.consumer.CommitFailedException: Commit cannot be completed since the group has already rebalanced
2024-03-15 09:16:05.678 [kafka-consumer-1] WARN  KafkaConsumer - Slow database queries blocking consumer thread
2024-03-15 09:16:10.789 [kafka-consumer-1] DEBUG KafkaConsumer - Processing message took 2345ms (threshold: 1000ms)
2024-03-15 09:16:15.890 [kafka-consumer-1] WARN  KafkaConsumer - Consumer lag now at 52341 messages
EOF

# Generate API Gateway access log
cat > logs/api-gateway-access.log << 'EOF'
2024-03-15 09:15:00.123 [gateway-worker-1] INFO  192.168.1.100 - - [15/Mar/2024:09:15:00 +0000] "POST /api/v1/orders HTTP/1.1" 201 456 "-" "Mozilla/5.0" 234ms
2024-03-15 09:15:01.234 [gateway-worker-2] INFO  192.168.1.101 - - [15/Mar/2024:09:15:01 +0000] "GET /api/v1/orders/550e8400-e29b-41d4-a716-446655440000 HTTP/1.1" 200 789 "-" "curl/7.68.0" 45ms
2024-03-15 09:15:02.345 [gateway-worker-3] ERROR 192.168.1.102 - - [15/Mar/2024:09:15:02 +0000] "POST /api/v1/payments HTTP/1.1" 504 0 "-" "axios/0.21.1" 8333ms
2024-03-15 09:15:03.456 [gateway-worker-4] INFO  192.168.1.103 - - [15/Mar/2024:09:15:03 +0000] "GET /api/v1/inventory/health HTTP/1.1" 200 45 "-" "k8s-probe" 12ms
2024-03-15 09:15:04.567 [gateway-worker-5] ERROR 192.168.1.104 - - [15/Mar/2024:09:15:04 +0000] "POST /api/v1/orders HTTP/1.1" 500 123 "-" "Mozilla/5.0" 567ms
2024-03-15 09:15:05.678 [gateway-worker-6] WARN  192.168.1.105 - - [15/Mar/2024:09:15:05 +0000] "PUT /api/v1/orders/660e8400-e29b-41d4-a716-446655440001/status HTTP/1.1" 409 234 "-" "axios/0.21.1" 123ms
2024-03-15 09:15:06.789 [gateway-worker-7] ERROR 192.168.1.106 - - [15/Mar/2024:09:15:06 +0000] "POST /api/v1/payments HTTP/1.1" 503 0 "-" "axios/0.21.1" 5001ms
2024-03-15 09:15:07.890 [gateway-worker-8] INFO  192.168.1.107 - - [15/Mar/2024:09:15:07 +0000] "GET /api/v1/orders/customer/770e8400-e29b-41d4-a716-446655440002 HTTP/1.1" 200 1234 "-" "Mozilla/5.0" 234ms
2024-03-15 09:15:08.901 [gateway-worker-9] ERROR 192.168.1.108 - - [15/Mar/2024:09:15:08 +0000] "POST /api/v1/orders/880e8400-e29b-41d4-a716-446655440003/confirm HTTP/1.1" 500 89 "-" "axios/0.21.1" 456ms
2024-03-15 09:15:09.012 [gateway-worker-10] INFO  192.168.1.109 - - [15/Mar/2024:09:15:09 +0000] "GET /api/v1/orders/health HTTP/1.1" 200 67 "-" "k8s-probe" 8ms
EOF

echo "Log files created ✓"

# Kafka configuration
cat > kafka/topics-config.yml << 'EOF'
topics:
  - name: order-events
    partitions: 12
    replication-factor: 3
    config:
      retention.ms: 604800000  # 7 days
      compression.type: snappy
      min.insync.replicas: 2
      
  - name: payment-events
    partitions: 8
    replication-factor: 3
    config:
      retention.ms: 604800000
      compression.type: snappy
      min.insync.replicas: 2
      
  - name: inventory-events
    partitions: 6
    replication-factor: 3
    config:
      retention.ms: 604800000
      compression.type: snappy
      min.insync.replicas: 2
EOF

cat > kafka/consumer-groups.md << 'EOF'
# Kafka Consumer Groups

## order-service-group
- **Service**: Order Service
- **Topics**: order-events
- **Partitions**: 12
- **Consumers**: 3 instances
- **Current Lag**: 52,341 messages (CRITICAL)

## payment-service-group
- **Service**: Payment Service  
- **Topics**: payment-events
- **Partitions**: 8
- **Consumers**: 2 instances
- **Current Lag**: 234 messages (OK)

## inventory-service-group
- **Service**: Inventory Service
- **Topics**: inventory-events
- **Partitions**: 6
- **Consumers**: 2 instances
- **Current Lag**: 89 messages (OK)
EOF

# Kafka message schemas
cat > kafka/message-schemas/order-events.json << 'EOF'
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "OrderEvent",
  "type": "object",
  "required": ["eventType", "orderId", "correlationId", "timestamp"],
  "properties": {
    "eventType": {
      "type": "string",
      "enum": ["order-created", "order-validated", "order-confirmed", "order-status-changed"]
    },
    "orderId": {
      "type": "string",
      "format": "uuid"
    },
    "orderNumber": {
      "type": "string"
    },
    "customerId": {
      "type": "string",
      "format": "uuid"
    },
    "status": {
      "type": "string",
      "enum": ["CREATED", "VALIDATED", "CONFIRMED", "SHIPPED", "DELIVERED", "CANCELLED"]
    },
    "totalAmount": {
      "type": "number"
    },
    "correlationId": {
      "type": "string"
    },
    "timestamp": {
      "type": "string",
      "format": "date-time"
    }
  }
}
EOF

cat > kafka/message-schemas/payment-events.json << 'EOF'
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "PaymentEvent",
  "type": "object",
  "required": ["eventType", "paymentId", "orderId", "correlationId"],
  "properties": {
    "eventType": {
      "type": "string",
      "enum": ["payment-initiated", "payment-completed", "payment-failed"]
    },
    "paymentId": {
      "type": "string",
      "format": "uuid"
    },
    "orderId": {
      "type": "string",
      "format": "uuid"
    },
    "amount": {
      "type": "number"
    },
    "status": {
      "type": "string"
    },
    "correlationId": {
      "type": "string"
    }
  }
}
EOF

cat > kafka/message-schemas/inventory-events.json << 'EOF'
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "InventoryEvent",
  "type": "object",
  "required": ["eventType", "productId", "correlationId"],
  "properties": {
    "eventType": {
      "type": "string",
      "enum": ["stock-reserved", "stock-released", "stock-updated"]
    },
    "productId": {
      "type": "string",
      "format": "uuid"
    },
    "quantity": {
      "type": "integer"
    },
    "correlationId": {
      "type": "string"
    }
  }
}
EOF

echo "Kafka configuration created ✓"

# API Gateway configuration
cat > api-gateway/routes.yml << 'EOF'
routes:
  - id: order-service
    uri: http://order-service:8080
    predicates:
      - Path=/api/v1/orders/**
    filters:
      - StripPrefix=0
      - name: CircuitBreaker
        args:
          name: orderServiceCircuitBreaker
          fallbackUri: forward:/fallback/orders
          
  - id: payment-service
    uri: http://payment-service:8080
    predicates:
      - Path=/api/v1/payments/**
    filters:
      - StripPrefix=0
      - name: CircuitBreaker
        args:
          name: paymentServiceCircuitBreaker
          fallbackUri: forward:/fallback/payments
          
  - id: inventory-service
    uri: http://inventory-service:8080
    predicates:
      - Path=/api/v1/inventory/**
    filters:
      - StripPrefix=0
EOF

cat > api-gateway/rate-limiting.yml << 'EOF'
rate-limiting:
  - path: /api/v1/orders
    limit: 1000
    period: 60s
    burst: 100
    
  - path: /api/v1/payments
    limit: 500
    period: 60s
    burst: 50
    
  - path: /api/v1/inventory
    limit: 2000
    period: 60s
    burst: 200
EOF

cat > api-gateway/security-policies.md << 'EOF'
# API Gateway Security Policies

## Authentication
- All requests require JWT token in Authorization header
- Token format: `Bearer <token>`
- Token expiry: 1 hour
- Refresh token expiry: 7 days

## Authorization
- Role-based access control (RBAC)
- Roles: CUSTOMER, ADMIN, SYSTEM

## Rate Limiting
- Per-endpoint limits defined in rate-limiting.yml
- 429 Too Many Requests returned when exceeded

## CORS
- Allowed origins: https://techmart.com, https://admin.techmart.com
- Allowed methods: GET, POST, PUT, DELETE
- Credentials: true
EOF

echo "API Gateway configuration created ✓"

# Service Mesh (Istio) configuration
cat > service-mesh/istio-config.yml << 'EOF'
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: order-service
spec:
  hosts:
    - order-service
  http:
    - route:
        - destination:
            host: order-service
            subset: v1
          weight: 100
      timeout: 30s
      retries:
        attempts: 3
        perTryTimeout: 10s
---
apiVersion: networking.istio.io/v1beta1
kind: DestinationRule
metadata:
  name: order-service
spec:
  host: order-service
  trafficPolicy:
    connectionPool:
      tcp:
        maxConnections: 100
      http:
        http1MaxPendingRequests: 50
        http2MaxRequests: 100
    outlierDetection:
      consecutiveErrors: 5
      interval: 30s
      baseEjectionTime: 30s
EOF

cat > service-mesh/traffic-management.yml << 'EOF'
# Circuit Breaker Configuration
circuit-breakers:
  order-service:
    consecutive-errors: 5
    interval: 30s
    base-ejection-time: 30s
    max-ejection-percent: 50
    
  payment-service:
    consecutive-errors: 3
    interval: 20s
    base-ejection-time: 60s
    max-ejection-percent: 30

# Retry Configuration  
retries:
  order-service:
    attempts: 3
    per-try-timeout: 10s
    retry-on: 5xx,reset,connect-failure
    
  payment-service:
    attempts: 2
    per-try-timeout: 5s
    retry-on: 5xx,reset

# Timeout Configuration
timeouts:
  order-service: 30s
  payment-service: 10s
  inventory-service: 15s
EOF

cat > service-mesh/observability-config.yml << 'EOF'
# Distributed Tracing
tracing:
  enabled: true
  sampling-rate: 0.1  # 10% of requests
  backend: jaeger
  jaeger:
    endpoint: http://jaeger-collector:14268/api/traces

# Metrics
metrics:
  enabled: true
  prometheus:
    scrape-interval: 15s
    retention: 15d
    
# Logging
logging:
  access-logs: true
  format: json
  level: info
EOF

echo "Service mesh configuration created ✓"

echo "All logs and configuration files generated successfully!"

# Made with Bob
