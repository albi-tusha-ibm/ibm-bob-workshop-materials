# API Gateway Security Policies

## Authentication
- All requests require JWT token in Authorization header
- Token format: `Bearer <token>`
- Token expiry: 1 hour
- Refresh token expiry: 7 days

## Authorization
- Role-based access control (RBAC)
- Roles: CUSTOMER, ADMIN, SYSTEM

## Rate Limiting
- Per-endpoint limits defined in rate-limiting.yml
- 429 Too Many Requests returned when exceeded

## CORS
- Allowed origins: https://techmart.com, https://admin.techmart.com
- Allowed methods: GET, POST, PUT, DELETE
- Credentials: true
