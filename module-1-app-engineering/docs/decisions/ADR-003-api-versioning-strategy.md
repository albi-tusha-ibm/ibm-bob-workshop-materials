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
