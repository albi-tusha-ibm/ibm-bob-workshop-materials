# Scenario: E-Commerce Platform Production Crisis

## Company Background

**TechMart Global** is a mid-sized e-commerce company processing 50,000+ orders daily across North America and Europe. The platform handles electronics, home goods, and consumer products with an average order value of $150.

### Key Metrics
- **Daily Orders**: 50,000-75,000
- **Peak Traffic**: 3,000 requests/second during sales events
- **Revenue**: $2.7B annually
- **Uptime SLA**: 99.9% (43 minutes downtime/month allowed)
- **Payment Success Rate Target**: 98.5%
- **Order Processing Time Target**: < 2 seconds

## Technical Architecture

### Microservices Overview

The platform migrated from a monolith to microservices 18 months ago. The current architecture consists of:

1. **Order Service** (Java 17, Spring Boot 3.1.5)
   - Manages order lifecycle (created → validated → confirmed → shipped → delivered)
   - Publishes order events to Kafka
   - Stores order data in PostgreSQL
   - Handles ~2,000 requests/minute

2. **Payment Service** (Java 17, Spring Boot 3.1.5)
   - Integrates with external payment gateway (StripeConnect API)
   - Performs fraud detection using rule-based engine
   - Processes ~1,500 payments/minute
   - Stores payment records in PostgreSQL

3. **Inventory Service** (Java 17, Spring Boot 3.1.5)
   - Manages product stock levels across 12 warehouses
   - Handles inventory reservations and releases
   - Syncs with warehouse management system
   - Processes ~3,000 stock checks/minute

### Infrastructure

- **Cloud Provider**: AWS (us-east-1, eu-west-1)
- **Container Orchestration**: Kubernetes 1.28
- **Service Mesh**: Istio 1.19
- **Message Broker**: Apache Kafka 3.5 (3 brokers, replication factor 3)
- **API Gateway**: Kong Gateway 3.4
- **Databases**: PostgreSQL 15 (RDS with read replicas)
- **Monitoring**: Prometheus + Grafana, Jaeger for distributed tracing

### Communication Patterns

**Synchronous (REST)**:
- External clients → API Gateway → Services
- Service-to-service calls for critical path operations

**Asynchronous (Kafka)**:
- Order events: `order-created`, `order-validated`, `order-confirmed`
- Payment events: `payment-initiated`, `payment-completed`, `payment-failed`
- Inventory events: `stock-reserved`, `stock-released`, `stock-updated`

## Current Production Issues

### Issue 1: Payment Timeout Crisis (P1 - Critical)

**Discovered**: March 15, 2024, 09:23 UTC  
**Impact**: 15% of payment requests timing out, causing order failures  
**Business Impact**: ~$180,000 in lost revenue per hour

**Symptoms**:
- Payment service responding with 504 Gateway Timeout
- StripeConnect API calls taking 8-12 seconds (normal: 1-2 seconds)
- Circuit breakers tripping intermittently
- Customer complaints spiking 300%

**Timeline**:
- **09:23 UTC**: First alerts for elevated payment latency
- **09:45 UTC**: Timeout rate reaches 10%
- **10:15 UTC**: Engineering team paged
- **10:30 UTC**: Timeout rate peaks at 18%
- **11:00 UTC**: Partial mitigation by increasing timeouts (band-aid fix)
- **Current**: Timeout rate stabilized at 15%, root cause unknown

**Hypotheses**:
1. External payment gateway degradation
2. Database connection pool exhaustion
3. Memory pressure causing GC pauses
4. Network latency between services

### Issue 2: Kafka Consumer Lag (P1 - Critical)

**Discovered**: March 14, 2024, 14:00 UTC  
**Impact**: Order processing delayed by 5-10 minutes  
**Business Impact**: Customer confusion, support ticket surge

**Symptoms**:
- Consumer lag on `order-events` topic reaching 50,000+ messages
- Order confirmations delayed
- Inventory not being reserved in time
- Rebalancing events occurring frequently

**Metrics**:
- Normal lag: < 100 messages
- Current lag: 45,000-60,000 messages
- Consumer throughput: 500 messages/second (normal: 1,200/second)
- Partition count: 12 partitions

**Potential Causes**:
1. Slow message processing in order service
2. Database queries blocking consumer threads
3. Insufficient consumer instances
4. Message deserialization issues

### Issue 3: Memory Leak in Order Service (P2 - High)

**Discovered**: March 13, 2024, 08:00 UTC  
**Impact**: Order service pods restarting every 4-6 hours  
**Business Impact**: Intermittent service disruptions

**Symptoms**:
- Heap memory usage growing from 2GB to 8GB over 4 hours
- OutOfMemoryError in logs
- Pods being OOMKilled by Kubernetes
- GC pauses increasing over time (50ms → 500ms)

**Observations**:
- Memory leak appears related to order caching mechanism
- Heap dumps show large number of Order objects retained
- WeakHashMap not releasing references as expected
- Issue worsens during high traffic periods

### Issue 4: Intermittent 503 Errors (P2 - High)

**Discovered**: March 12, 2024, 16:30 UTC  
**Impact**: 2-3% of API requests failing  
**Business Impact**: Poor user experience, cart abandonment

**Symptoms**:
- API Gateway returning 503 Service Unavailable
- Errors occur in bursts (30-60 seconds)
- All three services affected
- Istio circuit breakers showing "open" state

**Pattern**:
- Errors spike during traffic surges
- Correlates with deployment events
- More frequent in EU region (eu-west-1)
- Health checks passing, but requests failing

## Recent Changes

### Deployments (Last 7 Days)

1. **March 18**: Payment service v2.4.1 - Added fraud detection rules
2. **March 16**: Order service v3.1.0 - Implemented order caching
3. **March 14**: Inventory service v1.8.2 - Database query optimization
4. **March 12**: Istio upgrade from 1.18 to 1.19
5. **March 10**: Kafka broker configuration changes (increased retention)

### Configuration Changes

1. **March 17**: Increased payment service timeout from 5s to 10s
2. **March 15**: Added new Kafka consumer group for analytics
3. **March 13**: Modified order service JVM heap from 4GB to 8GB
4. **March 11**: Updated API Gateway rate limiting rules

## Team Context

### On-Call Rotation
- **Primary**: Sarah Chen (Senior SRE)
- **Secondary**: Marcus Rodriguez (Platform Engineer)
- **Escalation**: Dr. Emily Watson (Principal Architect)

### Recent Team Changes
- Lead backend engineer left 2 weeks ago
- New team member onboarding
- Documentation update backlog of 3 months
- Technical debt from monolith migration

## Business Context

### Upcoming Events
- **March 25**: Spring Sale (expected 3x traffic)
- **March 30**: New product launch (high-profile)
- **April 1**: Q1 board presentation

### Stakeholder Pressure
- CEO demanding immediate resolution
- Customer support overwhelmed with complaints
- Marketing team concerned about sale readiness
- Finance tracking revenue impact hourly

## Your Mission

As the engineer investigating these issues, you need to:

1. **Understand the System**: Navigate the codebase, configs, and documentation
2. **Analyze the Problems**: Use logs, metrics, and traces to identify root causes
3. **Propose Solutions**: Recommend fixes with risk assessment
4. **Document Findings**: Create incident reports and update documentation
5. **Prevent Recurrence**: Suggest architectural improvements

## Available Resources

- **Source Code**: All three microservices with full history
- **Logs**: Production logs from the last 48 hours
- **Configuration**: Kubernetes, Kafka, Istio, and application configs
- **Documentation**: Architecture docs, API specs, runbooks (some outdated)
- **Incident Reports**: Previous incidents with postmortems
- **Monitoring**: Prometheus metrics, Grafana dashboards, Jaeger traces

## Success Criteria

You'll successfully complete this scenario when you can:

1. Trace a failed payment request through the entire system
2. Explain the root cause of each production issue
3. Identify configuration mismatches and documentation gaps
4. Draft professional incident reports with action items
5. Propose architectural improvements with trade-off analysis

## Time Pressure

The Spring Sale is in 24 hours. The executive team needs:
- Root cause analysis by end of day
- Mitigation plan within 4 hours
- Long-term fixes scoped for next sprint

**The clock is ticking. Let's dive in.**

---

*This scenario is designed to simulate real-world production incidents with incomplete information, time pressure, and complex distributed systems. Use Bob to navigate the complexity and find the signal in the noise.*