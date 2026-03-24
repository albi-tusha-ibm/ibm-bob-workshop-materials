# Kafka Consumer Groups

## order-service-group
- **Service**: Order Service
- **Topics**: order-events
- **Partitions**: 12
- **Consumers**: 3 instances
- **Current Lag**: 52,341 messages (CRITICAL)

## payment-service-group
- **Service**: Payment Service  
- **Topics**: payment-events
- **Partitions**: 8
- **Consumers**: 2 instances
- **Current Lag**: 234 messages (OK)

## inventory-service-group
- **Service**: Inventory Service
- **Topics**: inventory-events
- **Partitions**: 6
- **Consumers**: 2 instances
- **Current Lag**: 89 messages (OK)
