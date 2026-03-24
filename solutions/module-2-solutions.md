# Module 2: IT Infrastructure - Reference Solutions

This document provides reference solutions for Module 2 exercises. These are **example approaches to inspire**, not prescriptive answers. Bob can help you discover multiple valid solutions.

---

## Exercise 1: Search and Discovery

### Task 1: Find servers with CPU utilization above 80%

**Example Bob Prompts:**
- "Search monitoring metrics for servers with CPU utilization above 80%"
- "Which servers are experiencing high CPU usage?"

**Expected Findings:**
- web-prod-01: 87% average, 94% peak
- web-prod-03: 85% average, 91% peak  
- app-prod-02: 83% average, 89% peak
- db-prod-primary: 82% average, 88% peak
- api-gateway-01: 86% average, 93% peak

**Recommendations:**
- Scale web tier horizontally (add 2 instances)
- Implement auto-scaling at 70% CPU threshold
- Review application performance for optimization opportunities

### Task 2: Identify firewall rules allowing unrestricted access

**Example Bob Prompts:**
- "Find firewall rules that allow SSH access from any IP (0.0.0.0/0)"
- "Show security group rules with unrestricted access"

**Expected Security Risks:**
- SSH (port 22) exposed to internet on production subnet
- RDP (port 3389) exposed to internet on Windows server
- PostgreSQL (port 5432) exposed to internet on database server

**Immediate Remediation:**
- Restrict SSH to corporate VPN range only
- Restrict RDP to jump box only
- Database should only accept connections from app tier

### Task 3: Locate critical security vulnerabilities

**Example Bob Prompts:**
- "Find all critical vulnerabilities with CVSS score > 7.0"
- "Summarize critical security vulnerabilities needing immediate attention"

**Expected Findings:**
- CVE-2024-1234: OpenSSL RCE (CVSS 9.8) - 23 servers affected
- CVE-2024-5678: Linux Kernel privilege escalation (CVSS 8.4) - 45 servers
- CVE-2024-9012: Apache HTTP RCE (CVSS 7.5) - 12 web servers
- CVE-2024-3456: PostgreSQL auth bypass (CVSS 8.1) - 8 database servers

**Prioritized Remediation:**
1. Week 1: Patch OpenSSL and PostgreSQL (critical)
2. Week 2: Update Linux kernel and Apache (high)
3. Week 3: Verify patches and re-scan

---

## Exercise 2: Summarization and Analysis

### Task 1: Summarize capacity trends and predict resource needs

**Example Bob Prompts:**
- "Summarize capacity trends and predict when we'll need additional resources"
- "Analyze CPU, memory, and storage trends to forecast capacity requirements"

**Expected Analysis:**

**Current State:**
- CPU: 68% average (↑31% from last month)
- Memory: 72% average (↑24% from last month)
- Storage: 142TB of 150TB used (94.7%)
- Growth: 2.1TB/week storage, 15% compute increase

**Critical Timeline:**
- Storage capacity exhaustion: 4 weeks
- Backup storage full: 2 weeks
- CPU threshold breach (>90%): 6 weeks

**Recommendations:**
- Immediate: Add 50TB storage, scale web tier by 3 instances
- Short-term: Implement auto-scaling, add read replicas
- Long-term: Migrate to tiered storage, implement data lifecycle policies

### Task 2: Analyze alert patterns

**Example Bob Prompts:**
- "Analyze critical alerts and identify the top 3 recurring issues"
- "What patterns do you see in alert data over the past 30 days?"

**Top 3 Recurring Issues:**

1. **High CPU Utilization** (45 occurrences)
   - Pattern: Daily 9 AM-5 PM EST
   - Affected: web-prod-01, web-prod-03
   - Solution: Auto-scaling, query optimization

2. **Storage Capacity Warnings** (38 occurrences)
   - Pattern: Daily backup warnings, weekly log warnings
   - Root cause: No log rotation, 180-day backup retention
   - Solution: Implement log rotation, reduce retention to 90 days

3. **VPN Tunnel Instability** (22 occurrences)
   - Pattern: 2-3 times per week, London-Dallas tunnel
   - Root cause: Configuration drift, insufficient bandwidth
   - Solution: Configuration management, redundant tunnel

---

## Exercise 3: Troubleshooting

### Task 1: Investigate network outage (INC-2024-101)

**Example Bob Prompts:**
- "Investigate the root cause of network outage INC-2024-101"
- "Analyze the network outage incident and identify what went wrong"

**Root Cause Analysis:**

**Primary Cause:** VPN configuration drift
- IPsec Phase 2 parameters mismatched between London and Dallas
- Pre-shared key rotated on Dallas but not updated on London
- Keepalive timer mismatch (30s vs 60s)

**Contributing Factors:**
- No configuration management (manual changes)
- No automated testing after changes
- Single point of failure (no redundant tunnel)

**Resolution:**
1. Synchronized IPsec configurations
2. Updated pre-shared keys on both sides
3. Verified tunnel establishment

**Preventive Measures:**
- Implement Ansible for firewall configuration
- Deploy redundant VPN tunnel
- Create automated health checks
- Update network documentation

### Task 2: Diagnose storage capacity issues (INC-2024-102)

**Example Bob Prompts:**
- "Investigate storage capacity incident and identify volumes at risk"
- "Analyze storage usage and recommend solutions"

**Critical Volumes:**
- /backup: 48TB of 50TB (96%) - 10 days to full
- /var/log: 4.5TB of 5TB (90%) - 12 days to full
- /data/warehouse: 92TB of 100TB (92%) - 6 weeks to full

**Root Causes:**
1. Backup retention too long (180 days, should be 90)
2. No log rotation or archival
3. No data lifecycle management

**Immediate Actions:**
```bash
# Delete backups older than 90 days (frees 28TB)
find /backup -type f -mtime +90 -delete

# Implement log rotation
logrotate -f /etc/logrotate.d/application

# Archive old warehouse data to S3 (frees 35TB)
aws s3 sync /data/warehouse s3://archive/ --storage-class GLACIER
```

**Long-term Strategy:**
- Implement tiered storage (hot/warm/cold/glacier)
- Automated data lifecycle policies
- Cost optimization: $45K → $28K/month (38% savings)

---

## Exercise 4: Documentation and Drafting

### Task 1: Create runbook for storage capacity alerts

**Example Bob Prompts:**
- "Draft a runbook for responding to high storage utilization alerts"
- "Create a procedure for handling storage capacity issues"

**Example Runbook:**

```markdown
# Runbook: Storage Capacity Alert Response

## Alert Trigger
Storage utilization > 85% on any volume

## Severity
- 85-90%: Warning (P2)
- 90-95%: High (P1)
- >95%: Critical (P0)

## Immediate Actions

1. **Identify affected volume:**
   ```bash
   df -h | grep -E '(8[5-9]|9[0-9]|100)%'
   ```

2. **Find largest files/directories:**
   ```bash
   du -sh /path/* | sort -rh | head -20
   ```

3. **Quick wins:**
   - Clear old logs: `find /var/log -mtime +30 -delete`
   - Remove old backups: `find /backup -mtime +90 -delete`
   - Clean package cache: `apt-get clean`

4. **Archive to S3:**
   ```bash
   aws s3 sync /data/old s3://archive/ --storage-class GLACIER
   ```

## Long-term Solutions
- Implement automated archival
- Set up data lifecycle policies
- Add storage capacity
- Monitor growth trends

## Escalation
If unable to free 10% capacity within 1 hour, escalate to Infrastructure Lead.
```

### Task 2: Draft incident report for network outage

**Example Bob Prompts:**
- "Create an incident report for INC-2024-101 following the RCA template"
- "Draft a comprehensive incident report for the network outage"

**Example Report:**

```markdown
# Incident Report: INC-2024-101

## Summary
VPN tunnel failure between London and Dallas data centers caused 2h 15m outage affecting 15% of European customers.

## Impact
- Duration: 2 hours 15 minutes
- Affected: 15% of European customers
- Revenue impact: ~$50,000
- Support tickets: 150+ complaints

## Root Cause
Configuration drift in VPN tunnel settings due to manual changes without proper change management.

## Timeline
- 14:00 UTC: Tunnel failure
- 14:12 UTC: Alerts triggered
- 14:35 UTC: Investigation begins
- 15:30 UTC: Root cause identified
- 16:15 UTC: Service restored

## Action Items
1. [P0] Implement Ansible for config management (Due: Apr 5)
2. [P0] Deploy redundant VPN tunnel (Due: Apr 12)
3. [P1] Create automated health checks (Due: Apr 8)
4. [P2] Update documentation (Due: Apr 10)
```

---

## Exercise 5: Reasoning and Planning

### Task 1: Capacity planning recommendations

**Example Bob Prompts:**
- "Based on capacity metrics, when should we scale infrastructure and by how much?"
- "Provide capacity planning recommendations for the next 6 months"

**Expected Recommendations:**

**Immediate (This Month):**
- Add 50TB storage capacity
- Scale web tier by 3 instances
- Implement auto-scaling

**3-Month Forecast:**
- Storage needs: +150TB (total 300TB)
- Compute needs: +30% capacity
- Network: Upgrade to 20Gbps

**6-Month Forecast:**
- Storage needs: +300TB (total 450TB)
- Compute needs: +60% capacity
- Consider multi-region expansion

**Cost Impact:**
- Current: $450K/month
- 3-month: $540K/month (+20%)
- 6-month: $630K/month (+40%)
- ROI: Prevents $2M+ in downtime costs

### Task 2: Security patching strategy

**Example Bob Prompts:**
- "Analyze security vulnerabilities and recommend a patching strategy that minimizes downtime"
- "Create a risk-based patching plan"

**Recommended Strategy:**

**Week 1: Critical Patches (No Reboot)**
- OpenSSL updates on all servers
- PostgreSQL updates (maintenance window)
- Apache updates on web tier

**Week 2: High Priority (Requires Reboot)**
- Linux kernel updates
- Rolling reboot: 5 servers per day
- Monitor for issues after each batch

**Week 3-4: Medium Priority**
- Batch patching during maintenance windows
- Focus on internet-facing systems first

**Risk Mitigation:**
- Test in staging environment first
- Take snapshots before patching
- Have rollback procedures ready
- Schedule during low-traffic windows
- Monitor closely post-patch

### Task 3: Architecture improvements for high availability

**Example Bob Prompts:**
- "Review current architecture and suggest improvements for high availability"
- "What architectural changes would improve system resilience?"

**Recommended Improvements:**

**1. Eliminate Single Points of Failure:**
- Deploy redundant VPN tunnels
- Add secondary load balancers
- Implement database replication
- Multi-AZ deployment for critical services

**2. Implement Auto-Scaling:**
- CPU-based scaling for web tier
- Queue-depth scaling for workers
- Predictive scaling for known patterns

**3. Improve Observability:**
- Distributed tracing across services
- Centralized logging with retention policies
- SLO-based alerting
- Automated anomaly detection

**4. Disaster Recovery:**
- Automated backups with testing
- Cross-region replication
- Regular DR drills
- Documented recovery procedures

**5. Infrastructure as Code:**
- Terraform for all infrastructure
- Version control for configurations
- Automated deployment pipelines
- Configuration drift detection

**Expected Outcomes:**
- Uptime: 99.7% → 99.95%
- MTTR: 45 min → 15 min
- Incident reduction: 50%
- Faster deployments: 2h → 30min

---

## Additional Tips

### Effective Bob Usage for Infrastructure
1. **Provide context:** Reference multiple files together (configs + logs + metrics)
2. **Ask comparative questions:** "Compare production vs staging configs"
3. **Request explanations:** "Why is this configuration causing issues?"
4. **Validate assumptions:** "Is this the correct approach for..."
5. **Explore alternatives:** "What are other ways to solve this?"

### Common Infrastructure Patterns
- Configuration drift detection
- Capacity planning with growth trends
- Security vulnerability prioritization
- Incident root cause analysis
- Documentation generation from configs

### Best Practices
- Always backup before making changes
- Test in non-production first
- Document all changes
- Monitor after changes
- Have rollback procedures ready
- Use infrastructure as code
- Implement proper change management

---

**Remember:** These solutions are starting points. Real infrastructure scenarios require adaptation based on specific constraints, compliance requirements, and business needs. Use Bob to explore alternatives and validate your approach!