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
