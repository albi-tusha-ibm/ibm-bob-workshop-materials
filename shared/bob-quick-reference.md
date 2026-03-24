# Bob Quick Reference Guide

Your essential guide to using Bob effectively in the workshop and beyond.

## 📖 Table of Contents
- [Getting Started](#getting-started)
- [Core Capabilities](#core-capabilities)
- [Prompting Best Practices](#prompting-best-practices)
- [Working with Large Codebases](#working-with-large-codebases)
- [File References](#file-references)
- [Common Patterns](#common-patterns)
- [Troubleshooting](#troubleshooting)
- [Advanced Tips](#advanced-tips)

---

## Getting Started

### What is Bob?

Bob is IBM's AI-powered coding assistant that helps you:
- **Understand** complex codebases quickly
- **Navigate** through large projects efficiently
- **Generate** code that matches your project's style
- **Debug** issues across multiple files
- **Document** code and architecture
- **Refactor** code with confidence

### How Bob Works

Bob analyzes your entire workspace context, including:
- File structure and organization
- Code relationships and dependencies
- Existing patterns and conventions
- Comments and documentation
- Configuration files

This contextual understanding allows Bob to provide relevant, accurate assistance.

### Basic Interaction

**Starting a conversation:**
- Open Bob in your IDE (check your IDE's Bob integration)
- Type your question or request
- Bob responds with analysis, suggestions, or code

**Continuing the conversation:**
- Ask follow-up questions
- Request clarifications or alternatives
- Refine Bob's suggestions iteratively

---

## Core Capabilities

### 1. Code Analysis
Bob can analyze code to:
- Explain what code does
- Identify potential issues
- Suggest improvements
- Review for best practices

**Example:**
```
"Analyze the authentication logic in user-service.ts for security issues"
```

### 2. Code Navigation
Bob helps you navigate by:
- Finding specific functions or classes
- Tracing execution flows
- Identifying dependencies
- Mapping architecture

**Example:**
```
"Show me all the places where the User model is imported and used"
```

### 3. Code Generation
Bob can generate:
- New functions or classes
- Tests
- Documentation
- Configuration files

**Example:**
```
"Create a new endpoint for updating user profiles that follows the existing REST patterns"
```

### 4. Debugging
Bob assists with debugging by:
- Analyzing error messages
- Tracing issues across files
- Suggesting fixes
- Identifying root causes

**Example:**
```
"Why might this API call be failing? Check the request format and error handling"
```

### 5. Refactoring
Bob helps refactor code by:
- Suggesting improvements
- Modernizing patterns
- Extracting reusable code
- Optimizing performance

**Example:**
```
"Refactor this function to use async/await instead of callbacks"
```

### 6. Documentation
Bob can create:
- Function/class documentation
- API documentation
- Architecture overviews
- README files

**Example:**
```
"Generate JSDoc comments for all functions in this file"
```

---

## Prompting Best Practices

### ✅ DO: Be Specific

**Good:**
```
"Analyze the order processing flow in order-service.ts and identify where inventory updates might fail"
```

**Bad:**
```
"Fix this code"
```

### ✅ DO: Provide Context

**Good:**
```
"I'm trying to add authentication to the API. We use JWT tokens and have a User model in models/user.ts. Show me how to implement a middleware that validates tokens."
```

**Bad:**
```
"Add authentication"
```

### ✅ DO: Ask Follow-up Questions

**Good conversation flow:**
1. "Explain the microservices architecture in this project"
2. "Which service handles user authentication?"
3. "Show me the authentication flow from login to token validation"
4. "What happens if the auth service is unavailable?"

### ✅ DO: Reference Specific Files

**Good:**
```
"Compare the error handling in api/orders.ts with api/users.ts and suggest a consistent approach"
```

**Bad:**
```
"Make error handling consistent"
```

### ✅ DO: Specify Desired Output

**Good:**
```
"List all REST endpoints in the order service with their HTTP methods, paths, and descriptions in a table format"
```

**Bad:**
```
"Show me the endpoints"
```

### ❌ DON'T: Be Vague

Avoid prompts like:
- "Make it better"
- "Fix the bug"
- "Optimize this"
- "Explain the code"

### ❌ DON'T: Assume Bob Knows Your Intent

Bob doesn't know:
- Your specific requirements unless you state them
- Your organization's coding standards (unless they're in the code)
- Your deployment environment
- Your team's preferences

### ❌ DON'T: Skip Verification

Always:
- Review Bob's suggestions before implementing
- Test generated code
- Verify security implications
- Check for edge cases

---

## Working with Large Codebases

### Strategy 1: Start Broad, Then Narrow

1. **Get the overview:**
   ```
   "Explain the overall architecture of this application"
   ```

2. **Focus on specific areas:**
   ```
   "Explain how the order processing module works"
   ```

3. **Drill into details:**
   ```
   "Show me the validation logic for order items"
   ```

### Strategy 2: Use Bob to Build a Mental Map

**Understand structure:**
```
"What are the main components of this system and how do they interact?"
```

**Identify patterns:**
```
"What design patterns are used in this codebase?"
```

**Find entry points:**
```
"Where does the application start? Show me the main entry points."
```

### Strategy 3: Trace Flows

**Follow data:**
```
"Trace the flow of data when a user places an order, from frontend to database"
```

**Follow execution:**
```
"What happens when the /api/checkout endpoint is called? Show the complete execution path."
```

### Strategy 4: Find Related Code

**Discover dependencies:**
```
"What other services or modules depend on the payment service?"
```

**Find similar implementations:**
```
"Show me all the places where we make HTTP requests to external APIs"
```

### Strategy 5: Understand Legacy Code

**Get context:**
```
"This code doesn't have comments. Explain what it does and why it might be structured this way."
```

**Identify issues:**
```
"What potential problems or technical debt exist in this module?"
```

---

## File References

### Explicit File References

**Single file:**
```
"Analyze the security of config/database.ts"
```

**Multiple files:**
```
"Compare the error handling in services/order.ts and services/payment.ts"
```

**Directory:**
```
"Review all files in the api/ directory for consistent error handling"
```

### Implicit References

Bob automatically considers:
- Currently open files
- Recently edited files
- Files in the current directory
- Related files (imports, dependencies)

### When to Be Explicit

Be explicit when:
- Working with files outside your current context
- Comparing specific files
- Analyzing files you haven't opened yet
- Referencing configuration or documentation files

---

## Common Patterns

### Pattern 1: Understanding New Code

```
1. "Give me an overview of what this project does"
2. "What are the main components?"
3. "Show me the data flow for [specific feature]"
4. "What external dependencies does this use?"
```

### Pattern 2: Adding a Feature

```
1. "Where should I add functionality for [feature]?"
2. "Show me similar existing implementations"
3. "What files will I need to modify?"
4. "Generate a skeleton implementation following existing patterns"
5. "What tests should I add?"
```

### Pattern 3: Debugging an Issue

```
1. "I'm seeing [error message]. What could cause this?"
2. "Trace the execution path that leads to this error"
3. "What are the possible failure points?"
4. "Show me the error handling for this scenario"
5. "Suggest a fix that handles this edge case"
```

### Pattern 4: Code Review

```
1. "Review this code for potential issues"
2. "Does this follow the project's existing patterns?"
3. "Are there any security concerns?"
4. "Suggest improvements for readability and maintainability"
5. "What edge cases might not be handled?"
```

### Pattern 5: Refactoring

```
1. "Identify code duplication in [module]"
2. "Suggest how to extract common functionality"
3. "Show me how to refactor this to use [pattern]"
4. "What would break if I change this?"
5. "Generate tests to ensure refactoring doesn't break functionality"
```

### Pattern 6: Documentation

```
1. "Generate documentation for this module"
2. "Create a README explaining how to use this API"
3. "Document the configuration options"
4. "Explain the architecture for new team members"
```

---

## Troubleshooting

### Bob Doesn't Understand My Question

**Try:**
- Rephrase your question more specifically
- Break complex questions into smaller parts
- Provide more context about what you're trying to achieve
- Reference specific files or code sections

**Example:**
Instead of: "Why doesn't this work?"
Try: "The login endpoint returns 401 even with valid credentials. Check the authentication middleware in auth/middleware.ts"

### Bob's Response is Too Generic

**Try:**
- Be more specific about what you want
- Reference specific files or patterns in your codebase
- Ask for examples that match your project's style
- Provide constraints or requirements

**Example:**
Instead of: "Create a user service"
Try: "Create a user service that follows the same pattern as order-service.ts, using TypeScript and the existing database connection"

### Bob Suggests Code That Doesn't Fit

**Try:**
- Show Bob examples of your preferred style
- Reference existing implementations to follow
- Specify frameworks, libraries, or patterns to use
- Ask Bob to match existing code conventions

**Example:**
"Generate a new API endpoint that follows the same structure as the endpoints in api/orders.ts"

### Bob Misses Important Context

**Try:**
- Explicitly mention relevant files or modules
- Provide background about the system architecture
- Explain constraints or requirements
- Reference related code or documentation

**Example:**
"We use a microservices architecture where each service has its own database. When creating the inventory service, ensure it doesn't directly access the order database."

### Bob's Analysis is Incomplete

**Try:**
- Ask follow-up questions to dig deeper
- Request specific aspects you want analyzed
- Ask Bob to consider additional scenarios
- Request alternative approaches

**Example:**
After initial analysis: "What about error handling? What happens if the database connection fails?"

---

## Advanced Tips

### Tip 1: Use Bob for Learning

Bob is an excellent learning tool:
```
"Explain the Observer pattern and show me where it's used in this codebase"
```

### Tip 2: Validate Assumptions

Use Bob to check your understanding:
```
"I think this code does X. Is that correct? What am I missing?"
```

### Tip 3: Explore Alternatives

Ask for multiple approaches:
```
"Show me three different ways to implement caching for this API, with pros and cons of each"
```

### Tip 4: Get Explanations at Different Levels

Adjust complexity as needed:
```
"Explain this algorithm like I'm a junior developer"
"Explain this algorithm with technical details for an experienced developer"
```

### Tip 5: Use Bob for Code Reviews

Before submitting code:
```
"Review my changes for potential issues, security concerns, and best practices"
```

### Tip 6: Leverage Bob's Context

Bob remembers your conversation:
```
1. "Analyze the authentication system"
2. "Now show me how to add two-factor authentication to it"
   (Bob remembers the authentication system from step 1)
```

### Tip 7: Ask for Explanations of Bob's Suggestions

If you don't understand a suggestion:
```
"Why did you suggest using a factory pattern here? What are the benefits?"
```

### Tip 8: Use Bob for Planning

Before coding:
```
"I need to add feature X. What files will I need to modify and what's the best approach?"
```

### Tip 9: Combine Multiple Requests

For complex tasks:
```
"Analyze the order processing flow, identify potential race conditions, and suggest how to make it thread-safe"
```

### Tip 10: Iterate and Refine

Don't settle for the first response:
```
1. "Create a user registration endpoint"
2. "Add email validation"
3. "Add password strength requirements"
4. "Add rate limiting to prevent abuse"
```

---

## Quick Command Reference

### Analysis Commands
- "Analyze [file/function] for [security/performance/bugs]"
- "Explain what [code/function] does"
- "Review [code] for best practices"
- "Identify potential issues in [file]"

### Navigation Commands
- "Find all uses of [function/class]"
- "Show me where [variable] is defined"
- "Trace the execution flow of [feature]"
- "What files are related to [functionality]?"

### Generation Commands
- "Create [function/class/test] that [does X]"
- "Generate [documentation/comments] for [code]"
- "Write a test for [function]"
- "Implement [feature] following [pattern]"

### Debugging Commands
- "Why is [code] failing?"
- "What could cause [error]?"
- "Debug [issue] in [file]"
- "Trace the source of [bug]"

### Refactoring Commands
- "Refactor [code] to [use pattern/improve readability]"
- "Extract [functionality] into a separate function"
- "Simplify [complex code]"
- "Optimize [code] for [performance/readability]"

### Documentation Commands
- "Document [code/API/module]"
- "Create a README for [project/module]"
- "Explain [architecture/design] for new developers"
- "Generate API documentation"

---

## Remember

1. **Bob is a tool, not a replacement** - Use Bob to augment your skills, not replace your judgment
2. **Always verify** - Review and test Bob's suggestions before implementing
3. **Iterate** - Don't expect perfect results on the first try; refine through conversation
4. **Provide context** - The more context you give, the better Bob's responses
5. **Learn from Bob** - Use Bob as a learning tool to understand new concepts and patterns
6. **Be specific** - Specific questions get specific, useful answers
7. **Ask follow-ups** - Build on previous responses to dig deeper
8. **Experiment** - Try different phrasings and approaches to find what works best

---

## Need More Help?

- **During workshop**: Ask your facilitator
- **Sample prompts**: See [sample-prompts.md](sample-prompts.md) for 50+ examples
- **Glossary**: Check [glossary.md](glossary.md) for technical terms
- **Practice**: The best way to learn is by using Bob on real tasks

---

**Ready to start?** Try asking Bob: "Explain the structure of this workshop repository and what each module covers."