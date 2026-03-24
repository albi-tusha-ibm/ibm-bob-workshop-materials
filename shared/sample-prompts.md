# Sample Prompts - 50+ Examples by Use Case

A comprehensive collection of example prompts to help you get the most out of Bob. Use these as templates and adapt them to your specific needs.

## 📑 Table of Contents
- [Code Search & Navigation](#code-search--navigation)
- [Code Analysis & Understanding](#code-analysis--understanding)
- [Summarization & Documentation](#summarization--documentation)
- [Troubleshooting & Debugging](#troubleshooting--debugging)
- [Code Generation](#code-generation)
- [Refactoring & Optimization](#refactoring--optimization)
- [Testing](#testing)
- [Security & Compliance](#security--compliance)
- [Architecture & Design](#architecture--design)
- [Learning & Reasoning](#learning--reasoning)

---

## Code Search & Navigation

### Finding Specific Code

**1. Find function definitions**
```
"Where is the calculateTotal function defined?"
```

**2. Find all usages**
```
"Show me all the places where the User model is imported and used"
```

**3. Find similar implementations**
```
"Find all functions that make HTTP requests to external APIs"
```

**4. Locate configuration**
```
"Where are the database connection settings configured?"
```

**5. Find entry points**
```
"What are the main entry points for this application? Show me where execution starts."
```

### Understanding Structure

**6. Get project overview**
```
"Explain the overall structure of this project. What are the main directories and their purposes?"
```

**7. Understand module relationships**
```
"How do the services in the backend/ directory interact with each other?"
```

**8. Map dependencies**
```
"What external libraries does this project depend on and what are they used for?"
```

**9. Trace data flow**
```
"Trace the flow of data when a user submits an order, from frontend to database"
```

**10. Identify patterns**
```
"What design patterns are used in this codebase? Show me examples of each."
```

---

## Code Analysis & Understanding

### Explaining Code

**11. Explain complex logic**
```
"Explain what this algorithm does and why it's implemented this way"
```

**12. Understand legacy code**
```
"This code has no comments and uses outdated patterns. Explain what it does and how it works."
```

**13. Explain business logic**
```
"Explain the business rules implemented in the order validation logic"
```

**14. Understand error handling**
```
"How does this service handle errors? What happens when external API calls fail?"
```

**15. Analyze performance**
```
"Analyze the performance characteristics of this function. Where are the bottlenecks?"
```

### Identifying Issues

**16. Find security vulnerabilities**
```
"Review this authentication code for security vulnerabilities"
```

**17. Identify code smells**
```
"Identify code smells and anti-patterns in this module"
```

**18. Find potential bugs**
```
"What edge cases or potential bugs exist in this payment processing logic?"
```

**19. Check for race conditions**
```
"Are there any race conditions in this concurrent code? Where might they occur?"
```

**20. Analyze error handling**
```
"Review the error handling in this API. What errors are not properly handled?"
```

---

## Summarization & Documentation

### Creating Documentation

**21. Generate function documentation**
```
"Generate JSDoc comments for all functions in this file"
```

**22. Create API documentation**
```
"Document all REST endpoints in the order service with request/response formats"
```

**23. Write README**
```
"Create a README for this module explaining its purpose, usage, and configuration"
```

**24. Document architecture**
```
"Create an architecture overview document explaining how the microservices interact"
```

**25. Generate changelog**
```
"Summarize the changes in this pull request for a changelog entry"
```

### Creating Summaries

**26. Summarize module**
```
"Provide a high-level summary of what the payment-service module does"
```

**27. Summarize changes**
```
"Summarize the key changes between the old and new implementation"
```

**28. Create onboarding guide**
```
"Create an onboarding guide for new developers joining this project"
```

**29. Explain configuration**
```
"Explain all the configuration options in config.json and their effects"
```

**30. Document dependencies**
```
"List all external dependencies and explain what each one is used for"
```

---

## Troubleshooting & Debugging

### Analyzing Errors

**31. Debug error message**
```
"I'm getting 'TypeError: Cannot read property 'id' of undefined'. Where could this be coming from?"
```

**32. Trace error source**
```
"The application crashes with a database connection error. Trace the connection setup and identify the issue."
```

**33. Debug API failure**
```
"The /api/checkout endpoint returns 500 errors. Analyze the endpoint and identify potential causes."
```

**34. Investigate timeout**
```
"API requests are timing out. Analyze the request flow and identify where delays might occur."
```

**35. Debug authentication issue**
```
"Users can't log in even with correct credentials. Debug the authentication flow."
```

### Root Cause Analysis

**36. Analyze failure scenario**
```
"Orders are being created but inventory isn't updating. Trace the flow and identify where it fails."
```

**37. Investigate data inconsistency**
```
"User balances don't match transaction history. Where could the discrepancy be introduced?"
```

**38. Debug integration issue**
```
"The payment gateway integration fails intermittently. What could cause this?"
```

**39. Analyze memory leak**
```
"Memory usage keeps growing. Identify potential memory leaks in this service."
```

**40. Debug concurrency issue**
```
"Multiple users editing the same resource causes data corruption. Where's the race condition?"
```

---

## Code Generation

### Creating New Code

**41. Generate API endpoint**
```
"Create a new REST endpoint for updating user profiles that follows the existing patterns in api/users.ts"
```

**42. Generate data model**
```
"Create a Product model with fields: id, name, price, description, inventory. Follow the same pattern as the User model."
```

**43. Generate middleware**
```
"Create authentication middleware that validates JWT tokens and attaches user info to the request"
```

**44. Generate utility function**
```
"Create a utility function to format currency values according to locale, similar to existing formatters"
```

**45. Generate configuration**
```
"Generate a Docker Compose file for this application with services for the app, database, and Redis"
```

### Implementing Features

**46. Add feature**
```
"Implement a password reset feature with email verification. Show me what files to create/modify."
```

**47. Add validation**
```
"Add input validation for the order creation endpoint using the same validation library as other endpoints"
```

**48. Add caching**
```
"Add Redis caching to the product listing endpoint to reduce database load"
```

**49. Add logging**
```
"Add structured logging to this service using the same logging framework as other services"
```

**50. Add monitoring**
```
"Add Prometheus metrics to track API response times and error rates"
```

---

## Refactoring & Optimization

### Improving Code Quality

**51. Refactor for readability**
```
"Refactor this complex function to be more readable and maintainable"
```

**52. Extract common code**
```
"Identify code duplication in the services/ directory and suggest how to extract common functionality"
```

**53. Modernize code**
```
"Refactor this callback-based code to use async/await"
```

**54. Apply design pattern**
```
"Refactor this code to use the Strategy pattern for different payment methods"
```

**55. Simplify logic**
```
"Simplify this nested if-else logic. Make it more readable and maintainable."
```

### Performance Optimization

**56. Optimize database queries**
```
"Optimize these database queries to reduce the number of round trips"
```

**57. Optimize algorithm**
```
"This sorting algorithm is slow for large datasets. Suggest a more efficient approach."
```

**58. Reduce memory usage**
```
"This function loads entire files into memory. Refactor to use streaming for large files."
```

**59. Optimize API calls**
```
"These API calls are made sequentially. Show how to parallelize them safely."
```

**60. Add pagination**
```
"Add pagination to this endpoint that currently returns all records"
```

---

## Testing

### Creating Tests

**61. Generate unit tests**
```
"Generate unit tests for the calculateDiscount function covering edge cases"
```

**62. Generate integration tests**
```
"Create integration tests for the order creation flow from API to database"
```

**63. Generate test data**
```
"Generate realistic test data for the User model including various edge cases"
```

**64. Create mock objects**
```
"Create mock objects for the external payment API used in tests"
```

**65. Generate E2E tests**
```
"Create end-to-end tests for the user registration and login flow"
```

### Test Analysis

**66. Identify missing tests**
```
"What test cases are missing for this authentication module?"
```

**67. Improve test coverage**
```
"Analyze test coverage and suggest additional tests for uncovered code paths"
```

**68. Review test quality**
```
"Review these tests for best practices and suggest improvements"
```

---

## Security & Compliance

### Security Analysis

**69. Security audit**
```
"Perform a security audit of this authentication system. Identify vulnerabilities."
```

**70. Check for SQL injection**
```
"Review this database code for SQL injection vulnerabilities"
```

**71. Analyze data exposure**
```
"Check if any sensitive data is being logged or exposed in error messages"
```

**72. Review access control**
```
"Review the authorization logic. Can users access resources they shouldn't?"
```

**73. Check encryption**
```
"Verify that sensitive data is properly encrypted at rest and in transit"
```

### Compliance

**74. GDPR compliance**
```
"Review this user data handling code for GDPR compliance. Are there any issues?"
```

**75. Audit trail**
```
"Does this financial transaction code maintain proper audit trails for compliance?"
```

**76. Data retention**
```
"Review data retention policies in this code. Are we complying with regulations?"
```

---

## Architecture & Design

### Design Decisions

**77. Compare approaches**
```
"Compare REST vs GraphQL for this API. What are the pros and cons for our use case?"
```

**78. Evaluate patterns**
```
"Should we use event sourcing for this order management system? What are the trade-offs?"
```

**79. Architecture review**
```
"Review this microservices architecture. Are there any anti-patterns or issues?"
```

**80. Scalability analysis**
```
"How will this system scale to 10x current load? What are the bottlenecks?"
```

**81. Technology selection**
```
"Compare PostgreSQL vs MongoDB for this use case. Which is more appropriate?"
```

### Planning

**82. Plan implementation**
```
"I need to add real-time notifications. What's the best approach and what files need changes?"
```

**83. Migration strategy**
```
"Plan a migration from this monolith to microservices. What's the safest approach?"
```

**84. Integration planning**
```
"How should we integrate with this third-party API? What patterns should we use?"
```

**85. Disaster recovery**
```
"What disaster recovery mechanisms should we add to this critical service?"
```

---

## Learning & Reasoning

### Understanding Concepts

**86. Explain pattern**
```
"Explain the Repository pattern and show me where it's used in this codebase"
```

**87. Learn from code**
```
"Teach me about circuit breakers by explaining how they're implemented here"
```

**88. Understand trade-offs**
```
"Explain the trade-offs between consistency and availability in this distributed system"
```

**89. Compare implementations**
```
"Compare how authentication is implemented in service A vs service B. Which is better?"
```

**90. Learn best practices**
```
"What are the best practices for error handling in microservices? Show examples from this code."
```

### Problem Solving

**91. Brainstorm solutions**
```
"Suggest three different ways to implement rate limiting, with pros and cons of each"
```

**92. Evaluate options**
```
"We need to add caching. Compare in-memory, Redis, and CDN approaches for our use case."
```

**93. Design solution**
```
"Design a solution for handling file uploads that can scale to millions of users"
```

**94. Troubleshoot approach**
```
"What's the best way to debug this distributed tracing issue across multiple services?"
```

**95. Optimize workflow**
```
"How can we optimize our deployment pipeline to reduce deployment time?"
```

---

## Tips for Using These Prompts

### Adaptation Strategies

1. **Replace placeholders**: Change file names, function names, and specifics to match your code
2. **Add context**: Include relevant details about your project, constraints, or requirements
3. **Combine prompts**: Mix and match elements from different prompts for complex tasks
4. **Iterate**: Start with a basic prompt and refine based on Bob's response

### Making Prompts More Effective

**Add specificity:**
- ❌ "Fix this code"
- ✅ "Refactor this authentication function to use async/await and add proper error handling"

**Provide context:**
- ❌ "Create a user service"
- ✅ "Create a user service following the same pattern as order-service.ts, using TypeScript and Prisma ORM"

**Reference examples:**
- ❌ "Add logging"
- ✅ "Add logging to this function using the same Winston logger configuration as in other services"

**Specify output format:**
- ❌ "List the endpoints"
- ✅ "List all REST endpoints in a markdown table with columns: Method, Path, Description, Auth Required"

### Common Prompt Patterns

**Analysis Pattern:**
```
"Analyze [code/file/module] for [security/performance/bugs/patterns]"
```

**Generation Pattern:**
```
"Create [component/function/test] that [does X] following [existing pattern/style]"
```

**Explanation Pattern:**
```
"Explain [code/concept/pattern] and show [examples/usage/implementation]"
```

**Comparison Pattern:**
```
"Compare [approach A] vs [approach B] for [use case] considering [criteria]"
```

**Troubleshooting Pattern:**
```
"[Problem description]. Analyze [relevant code] and identify [root cause/solution]"
```

---

## Practice Exercises

Try these prompts with the workshop code:

### Exercise 1: Navigation
```
"Show me the complete architecture of this workshop repository. What modules exist and how are they organized?"
```

### Exercise 2: Analysis
```
"Analyze the shared resources in this workshop. What reference materials are provided?"
```

### Exercise 3: Learning
```
"Explain the workshop structure and learning objectives for each module"
```

### Exercise 4: Planning
```
"If I wanted to add a fourth module on DevOps practices, what should it include and how should it be structured?"
```

---

## Advanced Prompt Techniques

### Multi-Step Prompts

Break complex tasks into steps:
```
1. "Analyze the current authentication system"
2. "Identify security vulnerabilities"
3. "Suggest improvements with code examples"
4. "Show how to implement the improvements"
5. "Generate tests for the new implementation"
```

### Contextual Prompts

Build on previous responses:
```
1. "Explain the microservices architecture"
2. "Now show me how service discovery works" (Bob remembers the architecture)
3. "What happens if the discovery service fails?" (Bob has full context)
```

### Comparative Prompts

Ask for multiple perspectives:
```
"Show me three different ways to implement authentication, optimized for: 1) Security, 2) Performance, 3) Simplicity"
```

### Constraint-Based Prompts

Specify requirements:
```
"Design a caching solution that: 1) Works with our existing Redis setup, 2) Handles cache invalidation, 3) Supports distributed systems, 4) Has minimal performance overhead"
```

---

## Remember

- **Start simple**: Begin with basic prompts and add complexity as needed
- **Be specific**: The more specific your prompt, the better the response
- **Iterate**: Refine prompts based on Bob's responses
- **Provide context**: Help Bob understand your goals and constraints
- **Verify**: Always review and test Bob's suggestions
- **Learn**: Use prompts as learning opportunities to understand concepts better

---

## Need More Examples?

- **Bob Quick Reference**: See [bob-quick-reference.md](bob-quick-reference.md) for prompting best practices
- **Glossary**: Check [glossary.md](glossary.md) for technical terms to use in prompts
- **Workshop Modules**: Each module has specific prompt examples for its scenarios

---

**Ready to try?** Pick a prompt from this guide, adapt it to your needs, and see what Bob can do!