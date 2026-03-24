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
