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
