# Module 1: Application Engineering

**Duration:** 25 minutes  
**Difficulty:** Intermediate to Advanced  
**Files:** ~150 files, ~5,000 lines of code

## Overview

This module demonstrates Bob's capabilities in a realistic enterprise scenario: a production e-commerce microservices platform experiencing critical issues. You'll work with a complex, event-driven architecture consisting of multiple Java/Spring Boot services, Kafka message brokers, API gateways, and service mesh configurations.

## Learning Objectives

By completing this module, you will learn how to use Bob to:

1. **Search & Navigate** complex codebases with multiple services and fragmented documentation
2. **Summarize & Synthesize** information scattered across logs, configs, and code
3. **Troubleshoot** production issues using correlation IDs, stack traces, and distributed tracing
4. **Draft** incident reports, API documentation, and architectural decision records
5. **Reason** about system behavior, root causes, and architectural trade-offs

## Architecture

The e-commerce platform consists of three core microservices:

- **Order Service**: Handles order creation, status updates, and order lifecycle management
- **Payment Service**: Processes payments, validates transactions, and performs fraud detection
- **Inventory Service**: Manages product stock, reservations, and availability

These services communicate asynchronously via Kafka and synchronously through an API Gateway with Istio service mesh for traffic management, observability, and resilience.

## Current Production Issues

The platform is experiencing several critical issues:

1. **Payment Timeouts**: 15% of payment requests timing out (P1 severity)
2. **Kafka Consumer Lag**: Order events backing up, causing delayed processing
3. **Memory Leak**: Order service memory usage growing unbounded
4. **Intermittent 503 Errors**: API Gateway returning service unavailable errors

## Module Structure

```
module-1-app-engineering/
├── README.md (this file)
├── scenario.md (detailed scenario context)
├── success-criteria.md (exercise completion criteria)
├── order-service/ (Order management microservice)
├── payment-service/ (Payment processing microservice)
├── inventory-service/ (Inventory management microservice)
├── kafka/ (Message broker configuration)
├── api-gateway/ (API Gateway routes and policies)
├── service-mesh/ (Istio configuration)
├── docs/ (Architecture, APIs, runbooks, ADRs)
├── logs/ (Production logs with real errors)
├── config/ (Kubernetes and monitoring configs)
├── incidents/ (Incident reports and postmortems)
└── tests/ (Integration and performance tests)
```

## Exercises

### Exercise 1: Search & Discovery (5 minutes)

**Objective**: Navigate the codebase and understand the system architecture.

**Tasks**:
1. Find all REST endpoints across the three services
2. Identify how services communicate (synchronous vs asynchronous)
3. Locate the Kafka topic configurations
4. Find where payment timeouts are configured

**Sample Prompts**:
- "Show me all REST API endpoints in this system"
- "How do the order and payment services communicate?"
- "Where are Kafka topics defined and what are their names?"
- "Find all timeout configurations in the payment service"

**Success Criteria**: You can describe the system's communication patterns and locate key configuration files.

---

### Exercise 2: Log Analysis & Troubleshooting (8 minutes)

**Objective**: Analyze production logs to identify root causes of issues.

**Tasks**:
1. Analyze payment-service logs to understand timeout patterns
2. Trace a failed order using correlation IDs across services
3. Identify the cause of Kafka consumer lag
4. Find evidence of the memory leak in order-service logs

**Sample Prompts**:
- "Analyze the payment service logs and identify why payments are timing out"
- "Trace order ID ORD-2024-03-15-7891 across all service logs"
- "What's causing the Kafka consumer lag in the order service?"
- "Find patterns in the order-service error log that suggest a memory leak"

**Success Criteria**: You can identify specific error patterns, trace requests across services, and explain root causes.

---

### Exercise 3: Documentation Synthesis (5 minutes)

**Objective**: Synthesize information from fragmented documentation.

**Tasks**:
1. Create a complete data flow diagram for order processing
2. Document the missing pieces in the deployment procedure
3. Identify conflicts between different documentation sources
4. Generate an up-to-date API integration guide

**Sample Prompts**:
- "Create a complete data flow diagram showing how an order flows through the system"
- "What information is missing from the deployment procedure?"
- "Are there any conflicts between the architecture docs and the actual code?"
- "Generate an API integration guide for external clients"

**Success Criteria**: You can identify documentation gaps, resolve conflicts, and create comprehensive documentation.

---

### Exercise 4: Incident Response (5 minutes)

**Objective**: Draft incident reports and propose solutions.

**Tasks**:
1. Complete the postmortem for INC-2024-001 (payment timeout)
2. Draft an incident report for the current Kafka lag issue
3. Propose architectural changes to prevent future incidents
4. Create action items with owners and timelines

**Sample Prompts**:
- "Complete the postmortem for the payment timeout incident"
- "Draft an incident report for the Kafka consumer lag issue"
- "What architectural changes would prevent these types of incidents?"
- "Create a prioritized action item list with recommendations"

**Success Criteria**: You can write professional incident reports with root cause analysis and actionable recommendations.

---

### Exercise 5: Code Review & Reasoning (2 minutes)

**Objective**: Analyze code quality and architectural decisions.

**Tasks**:
1. Review error handling in the payment service
2. Evaluate the fraud detection logic
3. Assess the order service's event publishing mechanism
4. Identify potential race conditions or concurrency issues

**Sample Prompts**:
- "Review the error handling in PaymentProcessor.java - what could be improved?"
- "Analyze the fraud detection logic - are there any edge cases?"
- "Is the order service's event publishing mechanism reliable?"
- "Are there any potential race conditions in the inventory reservation code?"

**Success Criteria**: You can identify code quality issues, architectural concerns, and propose improvements.

---

## Tips for Success

1. **Start Broad, Then Narrow**: Begin with high-level questions, then drill into specifics
2. **Use Correlation IDs**: Track requests across services using correlation IDs in logs
3. **Cross-Reference**: Compare code, configs, and documentation to find discrepancies
4. **Think Like an Engineer**: Consider performance, reliability, and maintainability
5. **Ask Follow-ups**: Don't hesitate to ask Bob clarifying questions

## Common Pitfalls

- **Assuming Documentation is Correct**: Documentation may be outdated or incomplete
- **Ignoring Configuration**: Many issues stem from misconfiguration, not code bugs
- **Missing Context**: Logs and errors often require context from multiple files
- **Overlooking Patterns**: Similar errors across services may indicate systemic issues

## Next Steps

After completing this module:
1. Review the `success-criteria.md` file to verify completion
2. Proceed to Module 2: Data Engineering
3. Reflect on how Bob helped you navigate complexity

## Resources

- [Scenario Details](scenario.md) - Full context about the e-commerce platform
- [Success Criteria](success-criteria.md) - Detailed completion requirements
- [Shared Resources](../shared/) - Bob quick reference and glossary

---

**Ready to begin?** Start with Exercise 1 and work through each exercise sequentially. Remember: Bob is your AI pair programmer - use him to navigate, analyze, and reason about this complex system!