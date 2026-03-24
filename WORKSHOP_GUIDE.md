# IBM Bob Workshop - Facilitator Guide

This guide provides detailed instructions for facilitating the IBM Bob Workshop, including timing, talking points, common questions, and adaptation strategies.

## 📋 Workshop Overview

**Duration**: 60 minutes  
**Format**: Hands-on, interactive  
**Audience**: Developers, engineers, technical leads  
**Group Size**: 5-30 participants (optimal: 10-15)  
**Prerequisites**: None - self-contained workshop

## ⏱️ Detailed Timing Breakdown

### Introduction (5 minutes)

**Objectives**:
- Set expectations and learning goals
- Introduce Bob's core capabilities
- Ensure everyone can access the repository

**Talking Points**:
1. **Welcome & Context** (1 min)
   - "Welcome to the IBM Bob Workshop. Over the next hour, you'll experience how Bob assists with real enterprise development scenarios."
   - "This is a hands-on workshop - you'll be using Bob directly, not just watching demos."

2. **Bob Overview** (2 min)
   - "Bob is IBM's AI-powered coding assistant that understands context, navigates complex codebases, and provides intelligent suggestions."
   - Key capabilities: code analysis, navigation, generation, debugging, documentation
   - "Bob works with you in your IDE, understanding your entire project context."

3. **Workshop Structure** (1 min)
   - Three persona-based modules: Infrastructure (15min), Application (25min), Financial (15min)
   - Each module has realistic scenarios and guided exercises
   - "Feel free to ask questions anytime - this is interactive!"

4. **Setup Check** (1 min)
   - "Please ensure you have the repository cloned and can see the files."
   - "Open `shared/bob-quick-reference.md` - we'll reference this throughout."
   - Quick poll: "Who has used AI coding assistants before?"

**Facilitation Tips**:
- Keep energy high and welcoming
- Acknowledge different experience levels
- Set ground rules: questions encouraged, experimentation welcome
- Have backup plan if technical issues arise

---

### Module 1: IT Infrastructure Engineering (15 minutes)

**Persona**: Infrastructure Engineer managing cloud deployments

**Time Allocation**:
- Introduction & Context: 2 minutes
- Exercise 1 (Terraform Analysis): 5 minutes
- Exercise 2 (K8s Troubleshooting): 5 minutes
- Discussion & Transition: 3 minutes

#### Introduction (2 min)

**Talking Points**:
- "You're now an infrastructure engineer responsible for cloud deployments."
- "Your team uses Terraform for IaC and Kubernetes for container orchestration."
- "Let's see how Bob helps with infrastructure code analysis and troubleshooting."

**Setup**:
- Navigate to `module-1-infrastructure/`
- Open the module README together
- Highlight the scenario context

#### Exercise 1: Terraform Security Analysis (5 min)

**Scenario**: Review Terraform configuration for security issues

**Guided Steps**:
1. "Open the Terraform files in the terraform/ directory"
2. "Ask Bob: 'Analyze these Terraform configurations for security vulnerabilities'"
3. "Notice how Bob identifies specific issues like exposed secrets, overly permissive IAM roles"
4. "Ask follow-up: 'How should I fix the S3 bucket public access issue?'"

**Key Observations**:
- Bob understands IaC-specific security patterns
- Provides actionable remediation steps
- References best practices (e.g., AWS Well-Architected Framework)

**Common Questions**:
- Q: "Can Bob fix the issues automatically?"
  - A: "Bob can suggest fixes and even generate corrected code. You review and apply changes."
- Q: "Does Bob know about our specific cloud provider policies?"
  - A: "Bob knows general best practices. You can provide your organization's policies as context."

#### Exercise 2: Kubernetes Troubleshooting (5 min)

**Scenario**: Debug a failing deployment

**Guided Steps**:
1. "Navigate to kubernetes/ directory"
2. "Ask Bob: 'Why is this deployment failing? Check the manifests.'"
3. "Bob will analyze resource limits, image pull policies, health checks"
4. "Try: 'Suggest improvements for production readiness'"

**Key Observations**:
- Bob understands K8s resource relationships
- Identifies configuration issues (missing probes, resource limits)
- Suggests production best practices

#### Discussion & Transition (3 min)

**Debrief Questions**:
- "What surprised you about Bob's infrastructure analysis?"
- "How could this help your daily work?"
- "What other infrastructure scenarios would be useful?"

**Transition**:
- "Infrastructure is one piece. Let's see how Bob handles application development - our longest module."

---

### Module 2: Application Engineering (25 minutes)

**Persona**: Full-stack developer working on microservices

**Time Allocation**:
- Introduction & Context: 3 minutes
- Exercise 1 (Architecture Navigation): 6 minutes
- Exercise 2 (API Analysis): 6 minutes
- Exercise 3 (Debugging): 6 minutes
- Discussion & Transition: 4 minutes

#### Introduction (3 min)

**Talking Points**:
- "You're now a full-stack developer on a microservices team."
- "The codebase has 8 services, multiple APIs, and complex dependencies."
- "This is where Bob really shines - navigating and understanding large codebases."

**Setup**:
- Navigate to `module-2-application/`
- Show the directory structure briefly
- "Don't worry about memorizing this - Bob will help us navigate."

#### Exercise 1: Architecture Navigation (6 min)

**Scenario**: Understand the microservices architecture

**Guided Steps**:
1. "Ask Bob: 'Explain the architecture of this application. What services exist and how do they interact?'"
2. "Bob will analyze the codebase and provide an overview"
3. "Follow-up: 'Show me the authentication flow from frontend to backend'"
4. "Try: 'Which services depend on the user-service?'"

**Key Observations**:
- Bob builds a mental model of the entire system
- Traces data flows across services
- Identifies dependencies without explicit documentation

**Facilitation Tips**:
- Encourage participants to ask their own questions
- Show how Bob references specific files in responses
- Highlight Bob's ability to synthesize information from multiple files

**Common Questions**:
- Q: "How does Bob know the architecture without a diagram?"
  - A: "Bob analyzes code structure, imports, API calls, and configuration files to understand relationships."
- Q: "Can Bob create architecture diagrams?"
  - A: "Bob can describe architecture and suggest diagram tools, but doesn't generate images directly."

#### Exercise 2: API Analysis (6 min)

**Scenario**: Understand API contracts and add a new endpoint

**Guided Steps**:
1. "Ask Bob: 'What are all the REST endpoints in the order-service?'"
2. "Bob will list endpoints with methods, paths, and descriptions"
3. "Try: 'Show me the request/response format for POST /orders'"
4. "Challenge: 'I need to add a GET /orders/{id}/status endpoint. Show me how.'"

**Key Observations**:
- Bob extracts API documentation from code
- Understands REST conventions and patterns
- Generates implementation suggestions that match existing code style

**Facilitation Tips**:
- Show how Bob references OpenAPI/Swagger if present
- Demonstrate asking for specific implementation details
- Encourage trying variations of prompts

#### Exercise 3: Cross-Service Debugging (6 min)

**Scenario**: Debug an issue affecting multiple services

**Guided Steps**:
1. "Scenario: Orders are being created but inventory isn't updating"
2. "Ask Bob: 'Trace the flow when a new order is created. Where might inventory updates fail?'"
3. "Bob will analyze the order creation flow across services"
4. "Follow-up: 'What error handling exists for inventory service failures?'"

**Key Observations**:
- Bob traces execution across service boundaries
- Identifies potential failure points
- Suggests improvements for resilience

**Advanced Prompts** (if time permits):
- "How should we implement retry logic for inventory updates?"
- "What monitoring should we add to detect this issue earlier?"

#### Discussion & Transition (4 min)

**Debrief Questions**:
- "How does Bob's code navigation compare to traditional IDE features?"
- "What would take hours manually that Bob did in seconds?"
- "How could this change your code review process?"

**Transition**:
- "Application development is complex, but some domains add extra challenges."
- "Let's look at financial services where compliance and accuracy are critical."

---

### Module 3: Financial Services Development (15 minutes)

**Persona**: Developer in a regulated financial institution

**Time Allocation**:
- Introduction & Context: 2 minutes
- Exercise 1 (Trading System Analysis): 5 minutes
- Exercise 2 (Compliance Verification): 5 minutes
- Discussion & Transition: 3 minutes

#### Introduction (2 min)

**Talking Points**:
- "You're now working at a financial institution with strict regulatory requirements."
- "Code changes must maintain compliance with regulations like MiFID II, Dodd-Frank."
- "Bob understands domain-specific terminology and can help ensure compliance."

**Setup**:
- Navigate to `module-3-financial/`
- Emphasize the importance of accuracy in financial systems
- "Bob helps, but humans verify - especially in regulated environments."

#### Exercise 1: Trading System Analysis (5 min)

**Scenario**: Understand risk calculation logic

**Guided Steps**:
1. "Ask Bob: 'Explain how Value at Risk (VaR) is calculated in the risk-engine'"
2. "Bob will break down the financial algorithm"
3. "Try: 'What market data inputs are required for this calculation?'"
4. "Follow-up: 'Are there any edge cases not handled?'"

**Key Observations**:
- Bob understands financial terminology (VaR, Greeks, settlement)
- Explains complex algorithms in clear terms
- Identifies potential issues in financial logic

**Facilitation Tips**:
- Don't assume everyone knows financial terms - Bob explains them
- Show how Bob can be a learning tool for domain knowledge
- Emphasize verification: "Bob's analysis is a starting point, not gospel"

**Common Questions**:
- Q: "Can Bob ensure regulatory compliance?"
  - A: "Bob can identify compliance-related code patterns and flag potential issues, but compliance verification requires human expertise and formal processes."
- Q: "Is Bob trained on financial regulations?"
  - A: "Bob has general knowledge of major regulations but should be supplemented with your organization's specific compliance requirements."

#### Exercise 2: Compliance Verification (5 min)

**Scenario**: Verify a code change maintains compliance

**Guided Steps**:
1. "Scenario: You need to modify the order execution logic"
2. "Ask Bob: 'What compliance requirements must be maintained when modifying order execution?'"
3. "Bob will identify audit logging, timestamp requirements, etc."
4. "Try: 'Review this change for MiFID II compliance' (provide a sample change)"

**Key Observations**:
- Bob identifies compliance-critical code sections
- Suggests necessary audit trails and documentation
- Flags potential regulatory issues

**Advanced Discussion** (if time permits):
- "How would you integrate Bob into a compliance review workflow?"
- "What additional safeguards would you add?"

#### Discussion & Transition (3 min)

**Debrief Questions**:
- "How does Bob handle domain-specific knowledge?"
- "What role should AI play in regulated environments?"
- "How would you use Bob while maintaining compliance?"

**Transition to Wrap-up**:
- "We've seen Bob across three very different domains."
- "Let's wrap up with key takeaways and next steps."

---

### Wrap-up & Q&A (5 minutes)

**Objectives**:
- Reinforce key learnings
- Address remaining questions
- Provide next steps and resources

#### Key Takeaways (2 min)

**Summarize**:
1. **Context Understanding**: "Bob analyzes entire codebases, not just single files"
2. **Domain Flexibility**: "Works across infrastructure, applications, and specialized domains"
3. **Interactive Learning**: "Bob is a conversation partner, not just a code generator"
4. **Productivity Multiplier**: "Handles tedious tasks so you focus on creative problem-solving"

**Prompting Best Practices Recap**:
- Be specific about what you want
- Provide context when needed
- Ask follow-up questions
- Verify Bob's suggestions

#### Q&A (2 min)

**Common Questions**:

**Q: "How accurate is Bob?"**
- A: "Bob is highly accurate for well-established patterns and languages. Always review suggestions, especially for critical systems."

**Q: "Will Bob replace developers?"**
- A: "No. Bob augments developers, handling routine tasks so you can focus on architecture, design, and complex problem-solving."

**Q: "What about security and data privacy?"**
- A: "Bob operates within your organization's security framework. Check with your security team about data handling policies."

**Q: "How do I get better at using Bob?"**
- A: "Practice! Use Bob daily for various tasks. The more you use it, the better you'll get at prompting."

**Q: "Can Bob work with legacy code?"**
- A: "Yes! Bob can analyze and explain legacy code, even in older languages or undocumented systems."

**Q: "What if Bob gives wrong information?"**
- A: "Always verify suggestions, especially for critical code. Bob is a tool to assist, not replace, your expertise."

#### Next Steps (1 min)

**Resources**:
- "Bookmark `shared/bob-quick-reference.md` for daily use"
- "Explore `shared/sample-prompts.md` for more examples"
- "Try Bob with your own projects - start small and build confidence"

**Encouragement**:
- "The best way to learn is by doing. Use Bob tomorrow for a real task."
- "Share your experiences with your team - Bob works better when teams adopt it together."

**Contact & Support**:
- Provide your contact information
- Share internal Bob support channels
- Mention any follow-up sessions or advanced workshops

---

## 🎯 Facilitation Tips

### General Best Practices

1. **Energy Management**
   - Keep pace brisk but not rushed
   - Use transitions to reset energy
   - Encourage participation throughout

2. **Handling Questions**
   - Welcome all questions - no question is too basic
   - If you don't know, say so and offer to follow up
   - Use questions to generate discussion

3. **Technical Issues**
   - Have backup examples ready
   - Can demo on your screen if participant has issues
   - Don't let technical problems derail the workshop

4. **Engagement Strategies**
   - Call on quiet participants occasionally
   - Use "think-pair-share" for complex questions
   - Share your own Bob experiences

5. **Time Management**
   - Set visible timer for exercises
   - Have "parking lot" for off-topic questions
   - Know what to skip if running behind

### Adapting for Different Audiences

#### For Beginners
- Spend more time on basics and prompting techniques
- Use simpler scenarios
- Provide more guided steps
- Emphasize that learning takes time

#### For Experienced Developers
- Move faster through basics
- Focus on advanced use cases
- Encourage experimentation
- Discuss integration with existing workflows

#### For Managers/Leaders
- Emphasize productivity gains and ROI
- Discuss team adoption strategies
- Focus on use cases relevant to their teams
- Address change management concerns

#### For Mixed Audiences
- Pair experienced with beginners
- Offer "challenge" variations of exercises
- Provide multiple difficulty levels
- Encourage peer learning

### Common Challenges & Solutions

#### Challenge: "Bob isn't working for me"
**Solutions**:
- Check Bob is properly configured
- Verify file is open in editor
- Try rephrasing the prompt
- Demo on your screen as backup

#### Challenge: "This seems too simple"
**Solutions**:
- Acknowledge and offer advanced exercises
- Ask them to try a complex scenario from their work
- Discuss integration with their specific tools
- Focus on strategic use cases

#### Challenge: "I don't trust AI-generated code"
**Solutions**:
- Validate their concern - verification is important
- Emphasize Bob as assistant, not replacement
- Show how Bob helps with review and understanding
- Discuss testing and validation practices

#### Challenge: "Running out of time"
**Solutions**:
- Skip to key exercises in each module
- Combine exercises if needed
- Extend Q&A to cover missed content
- Offer to share additional resources

#### Challenge: "Too much time remaining"
**Solutions**:
- Dive deeper into advanced scenarios
- Open floor for participant questions/scenarios
- Discuss integration strategies
- Share advanced tips and tricks

---

## 📊 Workshop Metrics & Feedback

### Success Indicators
- Participants can articulate Bob's key capabilities
- Attendees successfully complete at least 2 exercises
- Positive engagement and questions throughout
- Participants express intent to use Bob in their work

### Feedback Collection
**Quick Poll at End**:
1. "How likely are you to use Bob in your work?" (1-5 scale)
2. "What was most valuable?" (open response)
3. "What would you like to learn more about?" (open response)

**Follow-up Survey** (optional):
- Send 1 week after workshop
- Ask about actual Bob usage
- Collect success stories
- Identify additional training needs

---

## 🔄 Continuous Improvement

### After Each Workshop
- Note what worked well and what didn't
- Update examples based on participant feedback
- Refine timing based on actual duration
- Add new scenarios based on requests

### Version Control
- Document changes to workshop content
- Share improvements with other facilitators
- Maintain consistency across sessions

---

## 📞 Facilitator Support

**Questions about this guide?**
- Contact: [Your internal training team]
- Slack: #bob-workshop-facilitators
- Email: bob-training@ibm.com

**Need additional resources?**
- Advanced workshop materials
- Custom scenario development
- Train-the-trainer sessions

---

**Good luck with your workshop! Remember: enthusiasm is contagious. If you're excited about Bob, your participants will be too!** 🚀