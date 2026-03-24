# Payment Service

Processes payments through external payment gateway (StripeConnect).

## Known Issues

### Payment Timeouts (P1 - Critical)
- 15% of payments timing out
- External API taking 8-12 seconds
- See: INC-2024-001-payment-timeout.md

## API Endpoints

- POST /api/v1/payments - Process payment
- GET /api/v1/payments/health - Health check
