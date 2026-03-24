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
