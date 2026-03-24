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
