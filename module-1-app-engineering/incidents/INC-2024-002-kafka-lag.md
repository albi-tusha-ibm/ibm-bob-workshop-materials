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
