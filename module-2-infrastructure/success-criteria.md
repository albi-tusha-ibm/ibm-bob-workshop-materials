# Success Criteria - Module 2: IT Infrastructure

This document outlines the completion criteria for each exercise in the Infrastructure module.

## Exercise 1: Search and Discovery ✓

**Time Allocation:** 3 minutes

### Completion Criteria

You have successfully completed this exercise when you can demonstrate:

1. **Infrastructure Search**
   - [ ] Used Bob to search for high-utilization servers in monitoring metrics
   - [ ] Located specific configuration patterns in Terraform files
   - [ ] Found security-related issues in firewall rules or vulnerability scans

2. **Pattern Recognition**
   - [ ] Identified at least 3 servers with CPU utilization >80%
   - [ ] Found firewall rules with overly permissive access (0.0.0.0/0)
   - [ ] Located critical vulnerabilities (CVSS >7.0) in security scan results

3. **Multi-File Analysis**
   - [ ] Searched across multiple file types (configs, logs, metrics)
   - [ ] Correlated findings from different sources
   - [ ] Used appropriate search parameters (regex, file patterns)

### Example Successful Interactions

- "Search the monitoring metrics for all servers with CPU utilization above 85%"
- "Find all firewall rules that allow SSH access from any IP address"
- "Show me all critical vulnerabilities in the security scan results"
- "Which Terraform resources are configured with public IP addresses?"

---

## Exercise 2: Summarization and Analysis ✓

**Time Allocation:** 3 minutes

### Completion Criteria

You have successfully completed this exercise when you can demonstrate:

1. **Data Summarization**
   - [ ] Generated a summary of capacity trends from monitoring data
   - [ ] Analyzed alert patterns to identify recurring issues
   - [ ] Summarized vulnerability scan results with prioritization

2. **Trend Analysis**
   - [ ] Identified resource utilization trends over time
   - [ ] Recognized patterns in alert frequency and types
   - [ ] Projected future capacity needs based on current growth

3. **Insight Generation**
   - [ ] Extracted actionable insights from complex data
   - [ ] Prioritized issues based on severity and business impact
   - [ ] Connected related problems across different systems

### Example Successful Interactions

- "Summarize the CPU and memory trends over the past 30 days and predict when we'll need to scale"
- "Analyze the critical alerts log and tell me the top 3 recurring issues"
- "Review the vulnerability scan results and create a prioritized remediation plan"
- "What are the main capacity bottlenecks based on the monitoring data?"

---

## Exercise 3: Troubleshooting ✓

**Time Allocation:** 4 minutes

### Completion Criteria

You have successfully completed this exercise when you can demonstrate:

1. **Root Cause Analysis**
   - [ ] Investigated at least one incident report (INC-2024-101 or INC-2024-102)
   - [ ] Identified potential root causes using logs and configurations
   - [ ] Traced issues across multiple infrastructure components

2. **Diagnostic Process**
   - [ ] Used Bob to correlate symptoms with configuration issues
   - [ ] Analyzed network, compute, or storage problems systematically
   - [ ] Referenced relevant documentation and best practices

3. **Solution Identification**
   - [ ] Proposed specific fixes for identified issues
   - [ ] Considered impact and dependencies of proposed changes
   - [ ] Validated solutions against infrastructure constraints

### Example Successful Interactions

- "Help me troubleshoot the network outage described in INC-2024-101"
- "Investigate why the storage capacity alert was triggered and what's consuming space"
- "Analyze the VPN configuration and identify why the tunnel keeps failing"
- "What's causing the high CPU utilization on the web tier servers?"

---

## Exercise 4: Documentation and Drafting ✓

**Time Allocation:** 3 minutes

### Completion Criteria

You have successfully completed this exercise when you can demonstrate:

1. **Runbook Creation**
   - [ ] Drafted a runbook for at least one operational procedure
   - [ ] Included clear steps, prerequisites, and validation checks
   - [ ] Referenced relevant configuration files and commands

2. **Incident Documentation**
   - [ ] Created or updated an incident report following the RCA template
   - [ ] Documented timeline, impact, root cause, and remediation
   - [ ] Included lessons learned and preventive measures

3. **Technical Documentation**
   - [ ] Updated or created infrastructure documentation
   - [ ] Filled gaps in existing documentation
   - [ ] Ensured documentation is clear and actionable

### Example Successful Interactions

- "Draft a runbook for responding to high CPU utilization alerts"
- "Create an incident report for INC-2024-102 following the root cause analysis template"
- "Update the disaster recovery plan with the missing backup verification procedures"
- "Document the security hardening steps that should be applied to new servers"

---

## Exercise 5: Reasoning and Planning ✓

**Time Allocation:** 2 minutes

### Completion Criteria

You have successfully completed this exercise when you can demonstrate:

1. **Strategic Analysis**
   - [ ] Evaluated capacity planning needs based on current trends
   - [ ] Assessed trade-offs between different infrastructure approaches
   - [ ] Considered business impact of technical decisions

2. **Recommendation Development**
   - [ ] Proposed specific infrastructure improvements
   - [ ] Justified recommendations with data and reasoning
   - [ ] Prioritized actions based on impact and urgency

3. **Risk Assessment**
   - [ ] Identified risks associated with current infrastructure state
   - [ ] Evaluated impact of proposed changes
   - [ ] Considered compliance and security implications

### Example Successful Interactions

- "Based on the capacity metrics, when should we scale up and by how much?"
- "Analyze the security vulnerabilities and recommend a patching strategy that minimizes downtime"
- "Review our current architecture and suggest improvements for high availability"
- "What's the ROI of implementing the recommended infrastructure changes?"

---

## Overall Module Completion ✓

You have successfully completed Module 2 when you have:

### Technical Skills
- [ ] Completed all 5 exercises
- [ ] Demonstrated proficiency with Bob's search capabilities
- [ ] Used Bob to analyze complex infrastructure data
- [ ] Leveraged Bob for troubleshooting and root cause analysis
- [ ] Generated documentation and reports with Bob's assistance
- [ ] Applied Bob's reasoning for strategic planning

### Understanding
- [ ] Understand how to use Bob for infrastructure management tasks
- [ ] Can navigate complex multi-file infrastructure codebases
- [ ] Know how to ask effective questions for different scenarios
- [ ] Recognize when to use search vs. summarization vs. reasoning

### Practical Application
- [ ] Can apply learned techniques to real infrastructure challenges
- [ ] Understand Bob's strengths for infrastructure engineering
- [ ] Know how to integrate Bob into daily infrastructure workflows

## Validation Checklist

Before moving to the next module, ensure you can answer "yes" to these questions:

- [ ] Did I successfully search across multiple infrastructure files?
- [ ] Did I generate useful summaries of monitoring and alert data?
- [ ] Did I troubleshoot at least one infrastructure issue?
- [ ] Did I create or update infrastructure documentation?
- [ ] Did I use Bob's reasoning for capacity or security planning?
- [ ] Do I understand how Bob can help with infrastructure tasks?
- [ ] Can I formulate effective prompts for infrastructure scenarios?

## Time Management

If you're running short on time, prioritize in this order:

1. **Exercise 1 (Search)** - Fundamental skill
2. **Exercise 3 (Troubleshooting)** - High practical value
3. **Exercise 2 (Summarization)** - Important for data analysis
4. **Exercise 5 (Reasoning)** - Strategic thinking
5. **Exercise 4 (Documentation)** - Can be done asynchronously

## Next Steps

After completing this module:

1. Review your interactions and note what worked well
2. Identify areas where you could improve your prompts
3. Consider how you'd apply these techniques to your own infrastructure
4. Proceed to Module 3 or revisit exercises as needed

## Getting Help

If you're stuck on any exercise:

- Review the sample prompts in the README
- Check the [Bob Quick Reference](../shared/bob-quick-reference.md)
- Try rephrasing your question in different ways
- Break complex questions into smaller parts
- Ask Bob for clarification or suggestions

---

**Congratulations on completing Module 2!** You now have practical experience using Bob for infrastructure engineering tasks.