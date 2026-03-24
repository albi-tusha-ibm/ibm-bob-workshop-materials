# Success Criteria - Application Engineering Module

This document defines the completion criteria for each exercise in the Application Engineering module. Use this as a checklist to verify you've successfully completed each exercise.

---

## Exercise 1: Search & Discovery

### Completion Criteria

✅ **Task 1.1: Find all REST endpoints**
- [ ] Identified all endpoints in OrderController.java
- [ ] Identified all endpoints in PaymentController.java
- [ ] Identified all endpoints in InventoryController.java
- [ ] Created a summary list with HTTP methods and paths
- [ ] Noted which endpoints are public vs internal

**Expected Output**: A comprehensive list of ~15-20 REST endpoints across all services.

✅ **Task 1.2: Identify communication patterns**
- [ ] Explained synchronous communication (REST between services)
- [ ] Explained asynchronous communication (Kafka events)
- [ ] Identified which operations use which pattern
- [ ] Understood why each pattern was chosen

**Expected Output**: Clear explanation of when services use REST vs Kafka, with examples.

✅ **Task 1.3: Locate Kafka configurations**
- [ ] Found topics-config.yml in kafka/ directory
- [ ] Identified all topic names (order-events, payment-events, inventory-events)
- [ ] Located consumer group configurations
- [ ] Found message schemas in kafka/message-schemas/

**Expected Output**: List of all Kafka topics with their configurations and purposes.

✅ **Task 1.4: Find timeout configurations**
- [ ] Located payment service timeout in application.yml
- [ ] Found Istio timeout configuration in service-mesh/
- [ ] Identified API Gateway timeout settings
- [ ] Noted any conflicts between different timeout values

**Expected Output**: Complete inventory of timeout configurations with their current values.

---

## Exercise 2: Log Analysis & Troubleshooting

### Completion Criteria

✅ **Task 2.1: Analyze payment timeout patterns**
- [ ] Opened payment-service-debug.log
- [ ] Identified timeout errors with timestamps
- [ ] Found correlation IDs for failed payments
- [ ] Analyzed timing information for StripeConnect API calls
- [ ] Identified pattern: external API calls taking 8-12 seconds

**Expected Output**: Root cause analysis explaining that external payment gateway is slow, not internal service issues.

✅ **Task 2.2: Trace failed order across services**
- [ ] Found order ORD-2024-03-15-7891 in order-service-error.log
- [ ] Traced same correlation ID in payment-service-debug.log
- [ ] Found related Kafka messages in kafka-consumer.log
- [ ] Reconstructed complete request flow
- [ ] Identified where the failure occurred

**Expected Output**: Complete timeline of the order's journey through the system with failure point identified.

✅ **Task 2.3: Identify Kafka consumer lag cause**
- [ ] Analyzed kafka-consumer.log for lag warnings
- [ ] Found slow database queries blocking consumer threads
- [ ] Identified rebalancing events
- [ ] Noted deserialization errors
- [ ] Connected lag to recent code changes

**Expected Output**: Explanation that slow DB queries in order service are causing consumer lag, with specific evidence.

✅ **Task 2.4: Find memory leak evidence**
- [ ] Found OutOfMemoryError in order-service-error.log
- [ ] Identified increasing GC pause times
- [ ] Located references to order caching mechanism
- [ ] Found pattern of memory growth over time
- [ ] Connected to recent deployment (v3.1.0)

**Expected Output**: Evidence linking memory leak to order caching implementation in recent deployment.

---

## Exercise 3: Documentation Synthesis

### Completion Criteria

✅ **Task 3.1: Create complete data flow diagram**
- [ ] Documented order creation flow
- [ ] Showed payment processing integration
- [ ] Included inventory reservation steps
- [ ] Added Kafka event flows
- [ ] Noted error handling paths

**Expected Output**: Text-based or visual diagram showing complete order processing flow from creation to confirmation.

✅ **Task 3.2: Document missing deployment information**
- [ ] Reviewed deployment-procedure.md
- [ ] Identified outdated steps
- [ ] Found missing rollback procedures
- [ ] Noted missing health check validation
- [ ] Listed missing post-deployment verification steps

**Expected Output**: List of gaps in deployment documentation with specific missing information.

✅ **Task 3.3: Identify documentation conflicts**
- [ ] Compared architecture docs with actual code
- [ ] Found mismatches in API specifications
- [ ] Identified outdated configuration examples
- [ ] Noted incorrect service dependencies
- [ ] Listed version mismatches

**Expected Output**: Detailed list of conflicts between documentation and reality, with recommendations for updates.

✅ **Task 3.4: Generate API integration guide**
- [ ] Compiled all API endpoints
- [ ] Added authentication requirements
- [ ] Included request/response examples
- [ ] Documented error codes
- [ ] Added rate limiting information

**Expected Output**: Comprehensive API integration guide suitable for external developers.

---

## Exercise 4: Incident Response

### Completion Criteria

✅ **Task 4.1: Complete payment timeout postmortem**
- [ ] Filled in root cause section
- [ ] Added detailed timeline
- [ ] Listed contributing factors
- [ ] Proposed immediate fixes
- [ ] Suggested long-term improvements

**Expected Output**: Professional postmortem document following INC-2024-001-payment-timeout.md template.

✅ **Task 4.2: Draft Kafka lag incident report**
- [ ] Created incident report with standard format
- [ ] Included impact assessment
- [ ] Documented detection and response timeline
- [ ] Performed root cause analysis
- [ ] Listed action items with owners

**Expected Output**: Complete incident report for Kafka consumer lag issue, ready for stakeholder review.

✅ **Task 4.3: Propose architectural changes**
- [ ] Identified systemic issues
- [ ] Proposed circuit breaker improvements
- [ ] Suggested monitoring enhancements
- [ ] Recommended database optimization
- [ ] Evaluated trade-offs for each proposal

**Expected Output**: Architectural improvement proposal with pros/cons and implementation effort estimates.

✅ **Task 4.4: Create action item list**
- [ ] Prioritized items (P0, P1, P2)
- [ ] Assigned owners to each item
- [ ] Set realistic timelines
- [ ] Identified dependencies
- [ ] Noted required resources

**Expected Output**: Prioritized action item list with owners, timelines, and success metrics.

---

## Exercise 5: Code Review & Reasoning

### Completion Criteria

✅ **Task 5.1: Review payment service error handling**
- [ ] Analyzed try-catch blocks in PaymentProcessor.java
- [ ] Identified missing error cases
- [ ] Found inadequate logging
- [ ] Noted lack of retry logic
- [ ] Suggested improvements

**Expected Output**: Code review comments with specific line numbers and improvement suggestions.

✅ **Task 5.2: Evaluate fraud detection logic**
- [ ] Reviewed FraudDetection.java rules
- [ ] Identified edge cases not covered
- [ ] Found potential false positives
- [ ] Noted performance concerns
- [ ] Suggested rule improvements

**Expected Output**: Analysis of fraud detection effectiveness with recommendations for enhancement.

✅ **Task 5.3: Assess event publishing mechanism**
- [ ] Reviewed OrderService.java event publishing
- [ ] Checked for message delivery guarantees
- [ ] Identified potential message loss scenarios
- [ ] Evaluated error handling
- [ ] Suggested reliability improvements

**Expected Output**: Assessment of event publishing reliability with specific concerns and solutions.

✅ **Task 5.4: Identify concurrency issues**
- [ ] Reviewed StockManager.java for race conditions
- [ ] Checked inventory reservation logic
- [ ] Identified potential double-booking scenarios
- [ ] Analyzed locking mechanisms
- [ ] Proposed concurrency improvements

**Expected Output**: List of potential race conditions with severity assessment and mitigation strategies.

---

## Overall Module Completion

### You have successfully completed this module when:

- [ ] All 5 exercises completed with passing criteria
- [ ] Can explain each production issue's root cause
- [ ] Can trace requests through the distributed system
- [ ] Can identify gaps and conflicts in documentation
- [ ] Can write professional incident reports
- [ ] Can reason about architectural trade-offs
- [ ] Understand how to use Bob for complex engineering tasks

### Verification Questions

Answer these to confirm your understanding:

1. **What is the root cause of the payment timeout issue?**
   - Expected: External payment gateway (StripeConnect) experiencing latency, not internal service issues

2. **Why is the Kafka consumer lagging?**
   - Expected: Slow database queries in order service blocking consumer threads

3. **What caused the memory leak in order service?**
   - Expected: Order caching mechanism (WeakHashMap) not releasing references properly

4. **How would you prevent the 503 errors?**
   - Expected: Improve circuit breaker configuration, add better health checks, implement graceful degradation

5. **What documentation needs updating?**
   - Expected: Deployment procedures, API specs, architecture diagrams, timeout configurations

### Time Benchmarks

- **Fast Completion**: 15-20 minutes (experienced with Bob)
- **Target Completion**: 25 minutes (first-time users)
- **Extended Completion**: 30-35 minutes (thorough exploration)

---

## Next Steps After Completion

1. ✅ Review your work against these criteria
2. ✅ Reflect on which Bob features were most helpful
3. ✅ Note any challenges or confusion points
4. ✅ Proceed to Module 2: Data Engineering
5. ✅ Share feedback on the workshop experience

---

**Congratulations on completing the Application Engineering module!** You've demonstrated the ability to navigate complex distributed systems, analyze production issues, and reason about architectural decisions using Bob as your AI pair programmer.