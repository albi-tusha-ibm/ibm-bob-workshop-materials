#!/bin/bash

# Script to generate documentation, K8s configs, incidents, and tests
set -e

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$BASE_DIR"

echo "Generating remaining module files..."

# Architecture Documentation
cat > docs/architecture/system-overview.md << 'EOF'
# System Architecture Overview

## High-Level Architecture

TechMart e-commerce platform uses a microservices architecture with event-driven communication.

### Core Services

1. **Order Service** (Port 8081)
   - Manages order lifecycle
   - Publishes order events to Kafka
   - PostgreSQL database

2. **Payment Service** (Port 8082)
   - Processes payments via StripeConnect
   - Fraud detection
   - PostgreSQL database

3. **Inventory Service** (Port 8083)
   - Manages stock levels
   - Handles reservations
   - PostgreSQL database

### Infrastructure

- **API Gateway**: Kong Gateway (routes external traffic)
- **Service Mesh**: Istio (traffic management, observability)
- **Message Broker**: Kafka (async communication)
- **Container Platform**: Kubernetes
- **Monitoring**: Prometheus + Grafana
- **Tracing**: Jaeger

### Communication Patterns

**Synchronous**: REST APIs for critical path operations
**Asynchronous**: Kafka events for eventual consistency

## Missing Details

- Load balancer configuration (TODO)
- Database replication topology (TODO)
- Disaster recovery procedures (TODO)
EOF

cat > docs/architecture/data-flow-diagram.md << 'EOF'
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
EOF

cat > docs/architecture/integration-patterns.md << 'EOF'
# Integration Patterns

## Event-Driven Architecture

### Pattern: Event Notification
- Services publish events when state changes
- Other services subscribe to relevant events
- Loose coupling between services

### Pattern: Event-Carried State Transfer
- Events contain full state information
- Reduces need for synchronous calls
- Trade-off: larger message size

## Saga Pattern

Order processing uses choreography-based saga:

1. Order created
2. Payment processed
3. Inventory reserved
4. Order confirmed

Compensation: If any step fails, previous steps are reversed.

## Circuit Breaker

- Prevents cascading failures
- Configured in Istio service mesh
- Fallback responses when service unavailable
EOF

# API Specifications
cat > docs/api-specs/order-api.yaml << 'EOF'
openapi: 3.0.0
info:
  title: Order Service API
  version: 3.1.0
  description: Order management API for TechMart e-commerce platform

servers:
  - url: https://api.techmart.com/v1
    description: Production
  - url: http://localhost:8081/api/v1
    description: Local development

paths:
  /orders:
    post:
      summary: Create a new order
      operationId: createOrder
      tags:
        - Orders
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/OrderRequest'
      responses:
        '201':
          description: Order created successfully
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Order'
        '400':
          description: Invalid request
        '500':
          description: Internal server error

  /orders/{id}:
    get:
      summary: Get order by ID
      operationId: getOrder
      tags:
        - Orders
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: string
            format: uuid
      responses:
        '200':
          description: Order found
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Order'
        '404':
          description: Order not found

components:
  schemas:
    Order:
      type: object
      properties:
        id:
          type: string
          format: uuid
        orderNumber:
          type: string
        customerId:
          type: string
          format: uuid
        status:
          type: string
          enum: [CREATED, VALIDATED, CONFIRMED, SHIPPED, DELIVERED, CANCELLED]
        totalAmount:
          type: number
        items:
          type: array
          items:
            $ref: '#/components/schemas/OrderItem'
    
    OrderItem:
      type: object
      properties:
        productId:
          type: string
          format: uuid
        quantity:
          type: integer
        unitPrice:
          type: number
    
    OrderRequest:
      type: object
      required:
        - customerId
        - items
      properties:
        customerId:
          type: string
          format: uuid
        items:
          type: array
          items:
            $ref: '#/components/schemas/OrderItem'
EOF

cat > docs/api-specs/payment-api.yaml << 'EOF'
openapi: 3.0.0
info:
  title: Payment Service API
  version: 2.4.1
  description: Payment processing API

paths:
  /payments:
    post:
      summary: Process payment
      requestBody:
        required: true
        content:
          application/json:
            schema:
              type: object
              properties:
                orderId:
                  type: string
                  format: uuid
                amount:
                  type: number
                paymentMethod:
                  type: string
      responses:
        '200':
          description: Payment processed
        '402':
          description: Payment failed
        '504':
          description: Gateway timeout
EOF

cat > docs/api-specs/inventory-api.yaml << 'EOF'
openapi: 3.0.0
info:
  title: Inventory Service API
  version: 1.8.2
  description: Inventory management API

paths:
  /inventory/reserve:
    post:
      summary: Reserve stock
      requestBody:
        required: true
        content:
          application/json:
            schema:
              type: object
              properties:
                productId:
                  type: string
                  format: uuid
                quantity:
                  type: integer
      responses:
        '200':
          description: Stock reserved
        '409':
          description: Insufficient stock
EOF

echo "API specifications created ✓"

# Runbooks
cat > docs/runbooks/deployment-procedure.md << 'EOF'
# Deployment Procedure

## Pre-Deployment Checklist

- [ ] Code reviewed and approved
- [ ] Tests passing in CI/CD
- [ ] Database migrations prepared
- [ ] Feature flags configured
- [ ] Rollback plan documented

## Deployment Steps

1. **Notify team** in #deployments Slack channel
2. **Deploy to staging** environment first
3. **Run smoke tests** on staging
4. **Deploy to production** using blue-green deployment
5. **Monitor metrics** for 15 minutes
6. **Verify health checks** passing

## Missing Information

- Exact kubectl commands (TODO)
- Database migration steps (TODO)
- Feature flag toggle procedure (TODO)

## Post-Deployment

- Update deployment log
- Monitor error rates
- Check Kafka consumer lag
EOF

cat > docs/runbooks/rollback-procedure.md << 'EOF'
# Rollback Procedure

## When to Rollback

- Error rate > 5%
- Response time > 2x baseline
- Critical functionality broken
- Database corruption detected

## Rollback Steps

1. **Stop deployment** immediately
2. **Revert to previous version** using Kubernetes
3. **Verify rollback** successful
4. **Notify stakeholders**
5. **Investigate root cause**

## Commands

```bash
# Rollback deployment
kubectl rollout undo deployment/order-service -n production

# Check rollback status
kubectl rollout status deployment/order-service -n production
```
EOF

cat > docs/runbooks/incident-response.md << 'EOF'
# Incident Response Procedures

## Severity Levels

- **P0 (Critical)**: Complete service outage
- **P1 (High)**: Major functionality impaired
- **P2 (Medium)**: Minor functionality impaired
- **P3 (Low)**: Cosmetic issues

## Response Process

1. **Detect**: Alerts trigger or user reports
2. **Assess**: Determine severity
3. **Respond**: Page on-call engineer
4. **Mitigate**: Apply immediate fixes
5. **Resolve**: Implement permanent solution
6. **Review**: Conduct postmortem

## On-Call Contacts

- Primary: Sarah Chen (sarah@techmart.com)
- Secondary: Marcus Rodriguez (marcus@techmart.com)
- Escalation: Dr. Emily Watson (emily@techmart.com)
EOF

# ADRs (Architectural Decision Records)
cat > docs/decisions/ADR-001-microservices-architecture.md << 'EOF'
# ADR-001: Microservices Architecture

## Status
Accepted

## Context
TechMart was running a monolithic application that was difficult to scale and deploy.

## Decision
Migrate to microservices architecture with separate services for orders, payments, and inventory.

## Consequences

### Positive
- Independent scaling of services
- Faster deployment cycles
- Technology diversity
- Better fault isolation

### Negative
- Increased operational complexity
- Distributed system challenges
- Network latency between services
- Data consistency challenges

## Date
2023-01-15
EOF

cat > docs/decisions/ADR-002-event-driven-design.md << 'EOF'
# ADR-002: Event-Driven Design

## Status
Accepted

## Context
Services need to communicate asynchronously to avoid tight coupling.

## Decision
Use Apache Kafka for event-driven communication between services.

## Consequences

### Positive
- Loose coupling between services
- Better scalability
- Event sourcing for audit trail
- Resilience to service failures

### Negative
- Eventual consistency
- Debugging complexity
- Kafka operational overhead
- Message ordering challenges

## Date
2023-02-20
EOF

cat > docs/decisions/ADR-003-api-versioning-strategy.md << 'EOF'
# ADR-003: API Versioning Strategy

## Status
Accepted

## Context
APIs need to evolve without breaking existing clients.

## Decision
Use URL path versioning (e.g., /api/v1/orders, /api/v2/orders).

## Consequences

### Positive
- Clear version identification
- Easy to route in API Gateway
- Backward compatibility

### Negative
- URL proliferation
- Multiple versions to maintain
- Migration complexity

## Date
2023-03-10
EOF

echo "Documentation created ✓"

# Kubernetes Configurations
cat > config/kubernetes/deployments/order-service.yaml << 'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: order-service
  namespace: production
spec:
  replicas: 3
  selector:
    matchLabels:
      app: order-service
  template:
    metadata:
      labels:
        app: order-service
        version: v3.1.0
    spec:
      containers:
      - name: order-service
        image: techmart/order-service:3.1.0
        ports:
        - containerPort: 8080
        env:
        - name: SPRING_PROFILES_ACTIVE
          value: "prod"
        - name: DB_PASSWORD
          valueFrom:
            secretKeyRef:
              name: order-service-secrets
              key: db-password
        resources:
          requests:
            memory: "2Gi"
            cpu: "500m"
          limits:
            memory: "8Gi"
            cpu: "2000m"
        livenessProbe:
          httpGet:
            path: /api/v1/orders/health
            port: 8080
          initialDelaySeconds: 30
          periodSeconds: 10
        readinessProbe:
          httpGet:
            path: /api/v1/orders/health
            port: 8080
          initialDelaySeconds: 20
          periodSeconds: 5
EOF

cat > config/kubernetes/deployments/payment-service.yaml << 'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: payment-service
  namespace: production
spec:
  replicas: 2
  selector:
    matchLabels:
      app: payment-service
  template:
    metadata:
      labels:
        app: payment-service
        version: v2.4.1
    spec:
      containers:
      - name: payment-service
        image: techmart/payment-service:2.4.1
        ports:
        - containerPort: 8080
        resources:
          requests:
            memory: "1Gi"
            cpu: "250m"
          limits:
            memory: "4Gi"
            cpu: "1000m"
EOF

cat > config/kubernetes/deployments/inventory-service.yaml << 'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: inventory-service
  namespace: production
spec:
  replicas: 2
  selector:
    matchLabels:
      app: inventory-service
  template:
    metadata:
      labels:
        app: inventory-service
        version: v1.8.2
    spec:
      containers:
      - name: inventory-service
        image: techmart/inventory-service:1.8.2
        ports:
        - containerPort: 8080
        resources:
          requests:
            memory: "1Gi"
            cpu: "250m"
          limits:
            memory: "4Gi"
            cpu: "1000m"
EOF

cat > config/kubernetes/services/service-definitions.yaml << 'EOF'
apiVersion: v1
kind: Service
metadata:
  name: order-service
  namespace: production
spec:
  selector:
    app: order-service
  ports:
  - port: 8080
    targetPort: 8080
  type: ClusterIP
---
apiVersion: v1
kind: Service
metadata:
  name: payment-service
  namespace: production
spec:
  selector:
    app: payment-service
  ports:
  - port: 8080
    targetPort: 8080
  type: ClusterIP
---
apiVersion: v1
kind: Service
metadata:
  name: inventory-service
  namespace: production
spec:
  selector:
    app: inventory-service
  ports:
  - port: 8080
    targetPort: 8080
  type: ClusterIP
EOF

cat > config/kubernetes/configmaps/app-config.yaml << 'EOF'
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
  namespace: production
data:
  kafka.bootstrap.servers: "kafka-1:9092,kafka-2:9092,kafka-3:9092"
  database.host: "postgres.prod.internal"
  log.level: "INFO"
EOF

echo "Kubernetes configurations created ✓"

# Monitoring Configurations
cat > config/monitoring/prometheus-rules.yml << 'EOF'
groups:
  - name: order-service-alerts
    interval: 30s
    rules:
      - alert: HighErrorRate
        expr: rate(http_requests_total{status=~"5.."}[5m]) > 0.05
        for: 5m
        labels:
          severity: critical
        annotations:
          summary: "High error rate detected"
          
      - alert: HighMemoryUsage
        expr: container_memory_usage_bytes{pod=~"order-service.*"} > 7000000000
        for: 10m
        labels:
          severity: warning
        annotations:
          summary: "Order service memory usage high"
          
      - alert: KafkaConsumerLag
        expr: kafka_consumer_lag > 10000
        for: 5m
        labels:
          severity: critical
        annotations:
          summary: "Kafka consumer lag exceeds threshold"
EOF

cat > config/monitoring/grafana-dashboards.json << 'EOF'
{
  "dashboard": {
    "title": "TechMart Services Overview",
    "panels": [
      {
        "title": "Request Rate",
        "targets": [
          {
            "expr": "rate(http_requests_total[5m])"
          }
        ]
      },
      {
        "title": "Error Rate",
        "targets": [
          {
            "expr": "rate(http_requests_total{status=~\"5..\"}[5m])"
          }
        ]
      },
      {
        "title": "Response Time (p95)",
        "targets": [
          {
            "expr": "histogram_quantile(0.95, rate(http_request_duration_seconds_bucket[5m]))"
          }
        ]
      }
    ]
  }
}
EOF

cat > config/monitoring/alert-definitions.yml << 'EOF'
alerts:
  - name: payment-timeout
    condition: payment_duration_seconds > 5
    severity: critical
    notification: pagerduty
    
  - name: order-service-down
    condition: up{job="order-service"} == 0
    severity: critical
    notification: pagerduty
    
  - name: high-kafka-lag
    condition: kafka_consumer_lag > 50000
    severity: critical
    notification: slack
EOF

echo "Monitoring configurations created ✓"

# Incident Reports
cat > incidents/INC-2024-001-payment-timeout.md << 'EOF'
# INC-2024-001: Payment Timeout Crisis

## Incident Summary

**Date**: March 15, 2024  
**Duration**: 2 hours 37 minutes  
**Severity**: P1 - Critical  
**Impact**: 15% of payment requests timing out, $180K/hour revenue loss

## Timeline

- **09:23 UTC**: First alerts for elevated payment latency
- **09:45 UTC**: Timeout rate reaches 10%
- **10:15 UTC**: Engineering team paged
- **10:30 UTC**: Timeout rate peaks at 18%
- **11:00 UTC**: Partial mitigation by increasing timeouts
- **12:00 UTC**: Incident resolved

## Root Cause

External payment gateway (StripeConnect) experiencing degraded performance. API calls taking 8-12 seconds instead of normal 1-2 seconds.

### Contributing Factors

1. No circuit breaker configured for external API calls
2. Timeout set too low (5 seconds)
3. No retry logic with exponential backoff
4. Insufficient monitoring of external dependencies

## Resolution

1. Increased timeout from 5s to 10s (temporary fix)
2. Contacted StripeConnect support
3. Gateway performance restored at 12:00 UTC

## Action Items

- [ ] Implement circuit breaker for payment gateway (Owner: Marcus, Due: Mar 20)
- [ ] Add retry logic with exponential backoff (Owner: Sarah, Due: Mar 22)
- [ ] Set up external dependency monitoring (Owner: DevOps, Due: Mar 18)
- [ ] Create runbook for payment gateway issues (Owner: Sarah, Due: Mar 17)
- [ ] Review all external API integrations (Owner: Emily, Due: Mar 25)

## Lessons Learned

1. Always implement circuit breakers for external dependencies
2. Monitor external service health proactively
3. Have fallback mechanisms for critical paths
4. Document vendor escalation procedures
EOF

cat > incidents/INC-2024-002-kafka-lag.md << 'EOF'
# INC-2024-002: Kafka Consumer Lag

**Date**: March 14, 2024  
**Severity**: P1 - Critical  
**Impact**: Order processing delayed 5-10 minutes

## Root Cause

Slow database queries in order service blocking Kafka consumer threads. Missing index on customer_id column causing full table scans.

## Resolution

1. Added database index on customer_id
2. Increased consumer timeout
3. Optimized validation queries

## Action Items

- [ ] Review all database queries for missing indexes
- [ ] Implement query performance monitoring
- [ ] Add consumer lag alerts
EOF

cat > incidents/INC-2024-003-memory-leak.md << 'EOF'
# INC-2024-003: Memory Leak in Order Service

**Date**: March 13, 2024  
**Severity**: P2 - High  
**Impact**: Service restarts every 4-6 hours

## Root Cause

Order caching mechanism using WeakHashMap combined with ConcurrentHashMap preventing garbage collection. Strong references in ConcurrentHashMap prevent WeakHashMap from releasing Order objects.

## Current Status

Under investigation. Temporary mitigation: restart service every 4 hours.

## Action Items

- [ ] Refactor caching mechanism (Owner: Marcus, Due: Mar 20)
- [ ] Implement cache eviction policy (Owner: Sarah, Due: Mar 22)
- [ ] Add cache size monitoring (Owner: DevOps, Due: Mar 16)
EOF

cat > incidents/postmortem-template.md << 'EOF'
# Incident Postmortem Template

## Incident Summary
- **Date**:
- **Duration**:
- **Severity**:
- **Impact**:

## Timeline
- **HH:MM**: Event description

## Root Cause
Detailed explanation of what caused the incident.

## Resolution
Steps taken to resolve the incident.

## Action Items
- [ ] Action item (Owner, Due date)

## Lessons Learned
What we learned from this incident.
EOF

echo "Incident reports created ✓"

# Test Files
cat > tests/integration/order-flow-test.java << 'EOF'
package com.enterprise.tests;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

/**
 * Integration test for complete order flow
 */
public class OrderFlowTest {
    
    @Test
    public void testCompleteOrderFlow() {
        // 1. Create order
        // 2. Validate order
        // 3. Process payment
        // 4. Confirm order
        // 5. Verify order status
        
        // TODO: Implement full integration test
    }
    
    @Test
    public void testOrderWithPaymentFailure() {
        // Test order flow when payment fails
        // Verify order status is updated correctly
        
        // TODO: Implement test
    }
}
EOF

cat > tests/integration/payment-integration-test.java << 'EOF'
package com.enterprise.tests;

import org.junit.jupiter.api.Test;

/**
 * Integration test for payment processing
 */
public class PaymentIntegrationTest {
    
    @Test
    public void testPaymentProcessing() {
        // Test payment gateway integration
        // TODO: Implement test
    }
    
    @Test
    public void testPaymentTimeout() {
        // Test payment timeout handling
        // TODO: Implement test
    }
}
EOF

cat > tests/performance/load-test-results.md << 'EOF'
# Load Test Results

## Test Configuration

- **Date**: March 10, 2024
- **Duration**: 30 minutes
- **Target**: 3,000 requests/second
- **Tool**: Apache JMeter

## Results

### Order Service
- **Average Response Time**: 234ms
- **95th Percentile**: 456ms
- **99th Percentile**: 789ms
- **Error Rate**: 0.5%

### Payment Service
- **Average Response Time**: 1,234ms
- **95th Percentile**: 2,345ms
- **99th Percentile**: 5,678ms
- **Error Rate**: 2.3%
- **Timeout Rate**: 1.5%

### Bottlenecks Identified

1. Payment gateway latency
2. Database connection pool exhaustion
3. Kafka consumer lag during peak load

## Recommendations

1. Increase payment service timeout
2. Optimize database queries
3. Scale Kafka consumers
EOF

echo "Test files created ✓"

echo ""
echo "========================================="
echo "All remaining files generated successfully!"
echo "========================================="
echo ""
echo "Module 1 is now complete with:"
echo "  - 3 microservices (Order, Payment, Inventory)"
echo "  - Realistic logs (500+ lines each)"
echo "  - Kafka, API Gateway, Service Mesh configs"
echo "  - Architecture documentation"
echo "  - API specifications (OpenAPI)"
echo "  - Runbooks and ADRs"
echo "  - Kubernetes deployments"
echo "  - Monitoring configurations"
echo "  - Incident reports"
echo "  - Test files"
echo ""

# Made with Bob
