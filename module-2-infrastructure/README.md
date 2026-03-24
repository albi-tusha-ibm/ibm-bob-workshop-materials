# Module 2: IT Infrastructure / Enterprise Platforms

**Duration:** 15 minutes  
**Difficulty:** Intermediate  
**Target Audience:** Infrastructure Engineers, DevOps Engineers, Platform Engineers

## Overview

This module demonstrates Bob's capabilities for managing hybrid cloud infrastructure at enterprise scale. You'll work with a realistic scenario involving 500+ servers across multiple data centers, complex networking configurations, and recent capacity and security issues that require investigation and resolution.

## Learning Objectives

By completing this module, you will learn how to use Bob to:

1. **Search and analyze** infrastructure configurations across multiple cloud providers and on-premises systems
2. **Summarize** complex monitoring data, alert patterns, and capacity trends
3. **Troubleshoot** infrastructure issues using logs, metrics, and configuration files
4. **Draft** infrastructure documentation, runbooks, and incident reports
5. **Reason** about capacity planning, security vulnerabilities, and architectural decisions

## Scenario

You are an infrastructure engineer at GlobalTech Enterprise, managing a hybrid cloud infrastructure that includes:

- **AWS Cloud:** 300+ EC2 instances, S3 storage, RDS databases
- **On-Premises Data Centers:** 200+ physical servers across 3 locations
- **Network Infrastructure:** Complex VPN configurations, load balancers, firewall rules
- **Monitoring Stack:** Prometheus, Grafana, custom alerting systems

### Recent Issues

1. **Capacity Crisis:** Several production servers are experiencing high CPU and memory utilization (>85%), with storage capacity warnings
2. **Security Vulnerabilities:** A recent vulnerability scan identified critical CVEs requiring immediate attention
3. **Network Incidents:** Intermittent connectivity issues between data centers
4. **Compliance Gaps:** Upcoming SOC 2 audit requires documentation updates

## Module Structure

```
module-2-infrastructure/
├── README.md (this file)
├── scenario.md (detailed scenario)
├── success-criteria.md (completion criteria)
├── cloud-infrastructure/
│   ├── terraform/ (IaC configurations)
│   ├── ansible/ (automation playbooks)
│   └── scripts/ (operational scripts)
├── monitoring/
│   ├── metrics/ (performance data)
│   ├── alerts/ (alert logs)
│   └── dashboards/ (visualization configs)
├── network/
│   ├── firewall-rules.txt
│   ├── load-balancer-config.conf
│   ├── dns-records.zone
│   └── vpn-configuration.md
├── security/
│   ├── vulnerability-scan-results.json
│   ├── compliance-report.md
│   ├── patch-management-log.csv
│   └── security-policies.md
├── docs/
│   ├── architecture-diagrams.md
│   ├── capacity-planning.md
│   ├── disaster-recovery-plan.md
│   └── sla-requirements.md
└── incidents/
    ├── INC-2024-101-network-outage.md
    ├── INC-2024-102-storage-capacity.md
    └── root-cause-analysis-template.md
```

## Exercises

### Exercise 1: Search and Discovery (3 minutes)

**Objective:** Use Bob to search across infrastructure configurations and identify critical issues.

**Tasks:**
- Find all servers with CPU utilization above 80%
- Identify firewall rules that allow unrestricted access (0.0.0.0/0)
- Locate all critical security vulnerabilities (CVSS score > 7.0)
- Search for expired SSL certificates in the configuration

**Sample Prompts:**
- "Search for all instances in the Terraform configuration with instance types larger than t3.large"
- "Find all critical alerts in the last 7 days related to storage capacity"
- "Show me all firewall rules that allow SSH access from any IP address"

### Exercise 2: Summarization and Analysis (3 minutes)

**Objective:** Have Bob summarize complex infrastructure data and identify trends.

**Tasks:**
- Summarize CPU and memory trends over the past 30 days
- Analyze alert patterns to identify recurring issues
- Review vulnerability scan results and prioritize remediation
- Summarize compliance status across different frameworks

**Sample Prompts:**
- "Summarize the capacity trends from the monitoring metrics and predict when we'll need additional resources"
- "Analyze the critical alerts log and identify the top 3 recurring issues"
- "Review the vulnerability scan results and create a prioritized remediation plan"

### Exercise 3: Troubleshooting (4 minutes)

**Objective:** Use Bob to investigate and diagnose infrastructure problems.

**Tasks:**
- Investigate the root cause of the network outage (INC-2024-101)
- Diagnose storage capacity issues on production servers
- Troubleshoot VPN connectivity problems between data centers
- Analyze load balancer configuration for performance bottlenecks

**Sample Prompts:**
- "Help me troubleshoot why servers in us-east-1 are experiencing high latency"
- "Investigate the storage capacity incident and identify which volumes are at risk"
- "Analyze the load balancer configuration and suggest optimizations"

### Exercise 4: Documentation and Drafting (3 minutes)

**Objective:** Have Bob draft infrastructure documentation and procedures.

**Tasks:**
- Create a runbook for handling storage capacity alerts
- Draft an incident report for the recent network outage
- Update the disaster recovery plan with missing procedures
- Document the security hardening steps for new servers

**Sample Prompts:**
- "Draft a runbook for responding to high CPU utilization alerts"
- "Create an incident report for INC-2024-102 following the RCA template"
- "Update the disaster recovery plan with backup verification procedures"

### Exercise 5: Reasoning and Planning (2 minutes)

**Objective:** Use Bob's reasoning capabilities for strategic infrastructure decisions.

**Tasks:**
- Evaluate capacity planning needs based on current trends
- Assess the impact of implementing recommended security patches
- Recommend network architecture improvements
- Propose a strategy for achieving SOC 2 compliance

**Sample Prompts:**
- "Based on the capacity metrics, when should we scale up our infrastructure and by how much?"
- "Analyze the security vulnerabilities and recommend a patching strategy that minimizes downtime"
- "Review our current architecture and suggest improvements for high availability"

## Success Criteria

See [success-criteria.md](./success-criteria.md) for detailed completion requirements.

## Tips for Success

1. **Start Broad, Then Narrow:** Begin with high-level searches and summaries, then drill into specific issues
2. **Use Context:** Reference multiple files together (e.g., metrics + alerts + configs) for better insights
3. **Ask Follow-ups:** Bob can refine answers based on your feedback
4. **Leverage Reasoning:** Ask "why" and "what if" questions to understand implications
5. **Iterate on Drafts:** Have Bob revise documentation based on your requirements

## Key Bob Features Demonstrated

- **Multi-file Analysis:** Reading and correlating data across 80+ files
- **Pattern Recognition:** Identifying trends in metrics and alert data
- **Technical Reasoning:** Understanding infrastructure dependencies and impacts
- **Documentation Generation:** Creating runbooks, reports, and procedures
- **Search Capabilities:** Finding specific configurations across large codebases

## Next Steps

After completing this module:
1. Review the [scenario.md](./scenario.md) for detailed context
2. Check [success-criteria.md](./success-criteria.md) for completion requirements
3. Start with Exercise 1 and progress through each exercise
4. Experiment with your own prompts and questions

## Additional Resources

- [Bob Quick Reference](../shared/bob-quick-reference.md)
- [Sample Prompts](../shared/sample-prompts.md)
- [Glossary](../shared/glossary.md)

---

**Ready to begin?** Open Bob and start with Exercise 1!