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
