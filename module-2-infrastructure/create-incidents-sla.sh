#!/bin/bash

BASE_DIR="module-2-infrastructure"

# Create sla-requirements.md
cat > "$BASE_DIR/docs/sla-requirements.md" << 'EOF'
# Service Level Agreement (SLA) Requirements

**Document Version:** 2.0  
**Effective Date:** January 1, 2024  
**Review Date:** December 31, 2024  
**Owner:** Infrastructure Team

## 1. Overview

This document defines the Service Level Agreements (SLAs) for GlobalTech Enterprise infrastructure and services.

## 2. Service Availability

### 2.1 Availability Targets

| Service Tier | Monthly Uptime | Annual Uptime | Max Downtime/Month | Max Downtime/Year |
|--------------|----------------|---------------|-------------------|-------------------|
| Critical | 99.95% | 99.95% | 21.6 minutes | 4.38 hours |
| High | 99.9% | 99.9% | 43.2 minutes | 8.76 hours |
| Standard | 99.5% | 99.5% | 3.6 hours | 43.8 hours |

### 2.2 Service Classifications

**Critical Services:**
- User authentication
- Payment processing
- Order management
- Database services
- Core API endpoints

**High Priority Services:**
- Reporting systems
- Analytics platform
- Admin interfaces
- Backup systems

**Standard Services:**
- Development environments
- Testing systems
- Internal tools

## 3. Performance Targets

### 3.1 Response Time

| Metric | Target | Measurement |
|--------|--------|-------------|
| API Response Time (p95) | < 500ms | 95th percentile |
| API Response Time (p99) | < 1000ms | 99th percentile |
| Page Load Time | < 2 seconds | Median |
| Database Query Time | < 100ms | Average |

### 3.2 Throughput

| Metric | Target | Peak Capacity |
|--------|--------|---------------|
| API Requests | 10,000 req/sec | 15,000 req/sec |
| Concurrent Users | 50,000 | 75,000 |
| Database Transactions | 5,000 TPS | 7,500 TPS |

### 3.3 Error Rates

| Metric | Target | Threshold |
|--------|--------|-----------|
| HTTP 5xx Errors | < 0.1% | Alert at 0.05% |
| HTTP 4xx Errors | < 1% | Alert at 0.5% |
| Failed Transactions | < 0.01% | Alert at 0.005% |

## 4. Support Response Times

### 4.1 Incident Response

| Severity | Response Time | Resolution Time | Escalation |
|----------|---------------|-----------------|------------|
| P1 - Critical | 15 minutes | 4 hours | Immediate |
| P2 - High | 1 hour | 8 hours | 2 hours |
| P3 - Medium | 4 hours | 24 hours | 8 hours |
| P4 - Low | 24 hours | 5 business days | N/A |

### 4.2 Severity Definitions

**P1 - Critical:**
- Complete service outage
- Data loss or corruption
- Security breach
- Payment processing failure

**P2 - High:**
- Significant performance degradation
- Major feature unavailable
- Affecting multiple customers
- Workaround not available

**P3 - Medium:**
- Minor performance issues
- Single feature affected
- Workaround available
- Limited customer impact

**P4 - Low:**
- Cosmetic issues
- Feature requests
- Documentation updates
- No customer impact

## 5. Maintenance Windows

### 5.1 Scheduled Maintenance

**Standard Maintenance Window:**
- **Day:** Sunday
- **Time:** 02:00 - 06:00 UTC
- **Frequency:** Monthly
- **Notification:** 7 days advance notice

**Emergency Maintenance:**
- **Notification:** 2 hours advance notice (when possible)
- **Approval:** CTO required
- **Communication:** All stakeholders notified

### 5.2 Maintenance Impact

| Type | Expected Downtime | Customer Impact |
|------|-------------------|-----------------|
| Standard | < 2 hours | Minimal |
| Database | < 1 hour | Read-only mode |
| Network | < 30 minutes | Brief interruption |
| Emergency | Variable | Communicated in advance |

## 6. Backup and Recovery

### 6.1 Backup SLAs

| Data Type | RPO | RTO | Backup Frequency |
|-----------|-----|-----|------------------|
| Database | 1 hour | 4 hours | Hourly |
| Application Data | 24 hours | 8 hours | Daily |
| Configuration | 1 hour | 2 hours | On change |
| User Files | 24 hours | 12 hours | Daily |

### 6.2 Recovery Objectives

**Recovery Time Objective (RTO):**
- Critical systems: 4 hours
- High priority systems: 8 hours
- Standard systems: 24 hours

**Recovery Point Objective (RPO):**
- Critical data: 1 hour
- High priority data: 4 hours
- Standard data: 24 hours

## 7. Security SLAs

### 7.1 Security Response

| Event Type | Detection Time | Response Time | Resolution Time |
|------------|----------------|---------------|-----------------|
| Critical Vulnerability | Real-time | 15 minutes | 24 hours |
| Security Incident | Real-time | 30 minutes | 4 hours |
| Patch Deployment | N/A | 7 days | 30 days |
| Access Request | N/A | 4 hours | 24 hours |

### 7.2 Compliance

- **SOC 2 Type II:** Maintain compliance
- **ISO 27001:** Maintain certification
- **PCI DSS:** Maintain compliance (if applicable)
- **GDPR:** Full compliance

## 8. Monitoring and Reporting

### 8.1 Monitoring Coverage

- **Infrastructure:** 24/7 automated monitoring
- **Applications:** Real-time performance monitoring
- **Security:** Continuous security monitoring
- **Logs:** Centralized log aggregation

### 8.2 Reporting Schedule

| Report Type | Frequency | Recipients |
|-------------|-----------|------------|
| Availability Report | Monthly | Management |
| Performance Report | Weekly | Engineering |
| Incident Summary | Monthly | All stakeholders |
| Capacity Planning | Quarterly | Management |
| Security Report | Monthly | Security team |

## 9. SLA Measurements

### 9.1 Calculation Method

**Availability:**
```
Availability % = (Total Time - Downtime) / Total Time × 100
```

**Exclusions from Downtime:**
- Scheduled maintenance (with proper notice)
- Customer-caused issues
- Force majeure events
- Third-party service failures

### 9.2 Monitoring Tools

- **Uptime:** Pingdom, StatusCake
- **Performance:** New Relic, Datadog
- **Logs:** ELK Stack, CloudWatch
- **Alerts:** PagerDuty, Opsgenie

## 10. SLA Credits and Penalties

### 10.1 Service Credits

| Availability Achieved | Service Credit |
|----------------------|----------------|
| < 99.95% but ≥ 99.0% | 10% |
| < 99.0% but ≥ 95.0% | 25% |
| < 95.0% | 50% |

### 10.2 Credit Calculation

```
Credit = (Monthly Service Fee × Credit Percentage)
```

### 10.3 Credit Request Process

1. Customer submits credit request within 30 days
2. Infrastructure team validates downtime
3. Finance processes credit within 15 days
4. Credit applied to next invoice

## 11. Escalation Procedures

### 11.1 Escalation Path

```
Level 1: On-Call Engineer (0-15 min)
    ↓
Level 2: Infrastructure Manager (15-60 min)
    ↓
Level 3: CTO (1-2 hours)
    ↓
Level 4: CEO (2+ hours, critical only)
```

### 11.2 Escalation Triggers

- SLA breach imminent
- Extended outage (>2 hours)
- Multiple service failures
- Security incident
- Data loss risk

## 12. Continuous Improvement

### 12.1 Review Process

- **Monthly:** SLA performance review
- **Quarterly:** SLA target assessment
- **Annually:** SLA agreement revision

### 12.2 Improvement Initiatives

- Post-incident reviews
- Root cause analysis
- Process improvements
- Technology upgrades
- Training and development

## 13. Contact Information

### 13.1 Support Channels

**24/7 Support:**
- Phone: +1-555-0100
- Email: support@globaltech.com
- Portal: support.globaltech.com

**Emergency Escalation:**
- Phone: +1-555-0911
- Email: emergency@globaltech.com

### 13.2 Key Contacts

| Role | Name | Email | Phone |
|------|------|-------|-------|
| VP Engineering | John Doe | john.doe@globaltech.com | +1-555-0101 |
| Infrastructure Manager | Jane Smith | jane.smith@globaltech.com | +1-555-0102 |
| On-Call Rotation | - | oncall@globaltech.com | +1-555-0100 |

## 14. Definitions

**Availability:** Percentage of time service is operational and accessible  
**Downtime:** Period when service is unavailable to users  
**Incident:** Unplanned interruption or reduction in service quality  
**Maintenance:** Planned work to improve or maintain services  
**Response Time:** Time from incident detection to initial response  
**Resolution Time:** Time from incident detection to full resolution

## 15. Document Control

**Approval:**
- Infrastructure Team: Jane Smith
- Legal: Legal Department
- Finance: Finance Department
- Executive: Sarah Johnson, CEO

**Next Review:** December 31, 2024

---

*This SLA is subject to the terms and conditions of the Master Service Agreement.*
EOF

# Create INC-2024-101-network-outage.md
cat > "$BASE_DIR/incidents/INC-2024-101-network-outage.md" << 'EOF'
# Incident Report: INC-2024-101

## Incident Summary

**Incident ID:** INC-2024-101  
**Title:** Network Outage - London Data Center  
**Severity:** P1 - Critical  
**Status:** Resolved  
**Date:** March 18, 2024  
**Duration:** 2 hours 15 minutes  
**Impact:** 15% of European customers experienced service disruption

## Timeline

### Detection and Response

**10:32 UTC** - Automated monitoring detects VPN tunnel failure to London DC  
**10:33 UTC** - PagerDuty alert triggers, on-call engineer paged  
**10:35 UTC** - On-call engineer acknowledges alert, begins investigation  
**10:40 UTC** - Multiple services in London DC confirmed unreachable  
**10:42 UTC** - Incident escalated to P1, incident commander assigned  
**10:45 UTC** - War room established, DR team activated  
**10:50 UTC** - Customer notification sent via status page  

### Investigation

**10:55 UTC** - Network team identifies VPN configuration drift  
**11:05 UTC** - Root cause identified: Automated config management overwrote VPN settings  
**11:15 UTC** - Decision made to failover to AWS rather than fix VPN immediately  
**11:20 UTC** - Failover to AWS us-east-1 initiated  

### Mitigation

**11:30 UTC** - Traffic redirected to AWS infrastructure  
**11:45 UTC** - Services restored, monitoring for stability  
**12:00 UTC** - Confirmed all services operational in AWS  
**12:15 UTC** - VPN configuration corrected  
**12:30 UTC** - VPN tunnel re-established  
**12:45 UTC** - Traffic gradually shifted back to London DC  
**12:47 UTC** - Incident resolved, all services normal  

## Impact Analysis

### Customer Impact

- **Affected Customers:** ~1,500 (15% of European customer base)
- **Service Degradation:** Complete loss of service for affected customers
- **Geographic Scope:** UK, Ireland, Northern Europe
- **Business Impact:** Estimated $45,000 in lost revenue

### System Impact

- **Affected Systems:**
  - London DC web servers (5 instances)
  - London DC application servers (3 instances)
  - VPN tunnel to London DC
  - Internal monitoring systems in London

- **Unaffected Systems:**
  - AWS infrastructure (primary)
  - Dallas DC
  - Singapore DC
  - Database services (replicated)

## Root Cause Analysis

### Primary Cause

Automated configuration management system (Ansible) overwrote VPN tunnel configuration during a scheduled run at 10:30 UTC.

### Contributing Factors

1. **Configuration Drift Detection:** No automated detection of VPN config changes
2. **Change Management:** Ansible playbook updated without proper testing
3. **Monitoring Gaps:** VPN tunnel monitoring had 5-minute check interval
4. **Documentation:** VPN configuration not properly documented in Ansible

### Why It Happened

1. **Why did the VPN fail?**  
   Ansible overwrote the VPN configuration with incorrect settings

2. **Why did Ansible overwrite the config?**  
   A recent playbook update included VPN configuration that wasn't tested

3. **Why wasn't it tested?**  
   Change was considered "minor" and bypassed full testing process

4. **Why did it bypass testing?**  
   No enforcement of testing requirements for "infrastructure" changes

5. **Why no enforcement?**  
   Change management process had exceptions for "routine" automation updates

## Resolution

### Immediate Actions Taken

1. Failover to AWS infrastructure (11:20 UTC)
2. Manual correction of VPN configuration (12:15 UTC)
3. Verification of VPN tunnel stability (12:30 UTC)
4. Gradual traffic restoration to London DC (12:45 UTC)

### Verification Steps

- [x] VPN tunnel operational
- [x] All services responding
- [x] Monitoring alerts cleared
- [x] Customer connectivity verified
- [x] Performance metrics normal

## Lessons Learned

### What Went Well

1. **Detection:** Automated monitoring quickly identified the issue
2. **Response:** On-call engineer responded within 3 minutes
3. **Communication:** Status page updated promptly
4. **Failover:** DR procedures worked as designed
5. **Team Coordination:** War room established quickly

### What Went Wrong

1. **Prevention:** Configuration change not properly tested
2. **Detection Delay:** 5-minute monitoring interval too long
3. **Change Management:** Process allowed untested changes
4. **Documentation:** VPN config not in version control
5. **Rollback:** No automated rollback capability

## Action Items

### Immediate (Completed)

- [x] Restore VPN tunnel (Owner: Network Team, Due: 2024-03-18)
- [x] Verify all services operational (Owner: Infrastructure Team, Due: 2024-03-18)
- [x] Document incident timeline (Owner: Incident Commander, Due: 2024-03-18)

### Short-term (In Progress)

- [ ] Implement VPN configuration monitoring (Owner: Network Team, Due: 2024-03-25)
- [ ] Add VPN config to version control (Owner: Infrastructure Team, Due: 2024-03-22)
- [ ] Review and update Ansible playbooks (Owner: Automation Team, Due: 2024-03-29)
- [ ] Reduce monitoring interval to 1 minute (Owner: Monitoring Team, Due: 2024-03-25)

### Long-term (Planned)

- [ ] Implement automated config drift detection (Owner: Infrastructure Team, Due: 2024-04-30)
- [ ] Enforce testing for all automation changes (Owner: Engineering Manager, Due: 2024-04-15)
- [ ] Implement automated rollback capability (Owner: Infrastructure Team, Due: 2024-05-31)
- [ ] Conduct DR drill focusing on network failures (Owner: Infrastructure Team, Due: 2024-06-30)

## Prevention Measures

### Process Improvements

1. **Change Management:**
   - All automation changes require testing in non-prod
   - Peer review required for infrastructure changes
   - No exceptions for "routine" changes

2. **Monitoring:**
   - Reduce VPN monitoring interval to 1 minute
   - Implement config drift detection
   - Alert on any VPN configuration changes

3. **Documentation:**
   - All network configs in version control
   - Automated documentation generation
   - Regular documentation audits

### Technical Improvements

1. **Automation:**
   - Implement dry-run mode for Ansible
   - Add validation checks before applying changes
   - Automated rollback on failure

2. **Monitoring:**
   - Real-time config change detection
   - Automated health checks after changes
   - Predictive alerting for potential issues

3. **Architecture:**
   - Implement redundant VPN tunnels
   - Add automatic failover capability
   - Improve network resilience

## Financial Impact

### Direct Costs

- Lost Revenue: $45,000
- Engineering Time: $8,000 (16 hours × $500/hour)
- **Total Direct Cost:** $53,000

### Indirect Costs

- Customer Support: $3,000
- SLA Credits: $12,000
- Reputation Impact: Unquantified
- **Total Indirect Cost:** $15,000+

**Total Estimated Impact:** $68,000+

## Communication

### Internal Communication

- Incident channel: #incident-2024-101
- War room: Zoom (15 participants)
- Status updates: Every 15 minutes
- Post-mortem: Scheduled for 2024-03-20

### External Communication

- Status page: 5 updates during incident
- Customer emails: 2 (initial + resolution)
- Social media: 3 tweets
- Support tickets: 47 created, all resolved

### Customer Notification

**Initial (10:50 UTC):**
"We are investigating connectivity issues affecting some European customers. Our team is working to resolve this as quickly as possible."

**Update 1 (11:30 UTC):**
"We have identified the issue and are implementing a fix. Services are being restored."

**Resolution (12:50 UTC):**
"The issue has been resolved. All services are now operational. We apologize for the inconvenience."

## Approval

**Incident Commander:** Jane Smith  
**Technical Lead:** Bob Johnson  
**Reviewed By:** John Doe, VP of Engineering  
**Approved By:** Sarah Johnson, CEO  
**Date:** March 19, 2024

---

**Post-Mortem Meeting:** March 20, 2024, 14:00 UTC  
**Attendees:** Infrastructure Team, Network Team, Engineering Management

*This document contains confidential incident information.*
EOF

# Create INC-2024-102-storage-capacity.md
cat > "$BASE_DIR/incidents/INC-2024-102-storage-capacity.md" << 'EOF'
# Incident Report: INC-2024-102

## Incident Summary

**Incident ID:** INC-2024-102  
**Title:** Storage Capacity Crisis - Backup System Failure  
**Severity:** P2 - High  
**Status:** Resolved  
**Date:** March 20, 2024  
**Duration:** Ongoing (mitigation in place)  
**Impact:** Backup retention policy violations, potential data loss risk

## Timeline

### Detection

**02:15 UTC** - Automated backup job fails due to insufficient storage  
**02:16 UTC** - Alert sent to on-call engineer  
**02:45 UTC** - On-call engineer investigates, identifies storage at 96% capacity  
**03:00 UTC** - Incident created, severity set to P2  
**03:15 UTC** - Infrastructure manager notified  

### Investigation

**03:30 UTC** - Storage analysis reveals faster than projected growth  
**04:00 UTC** - Identified causes: log retention, database growth, backup accumulation  
**04:30 UTC** - Calculated immediate storage needs: additional 25TB required  

### Mitigation

**05:00 UTC** - Emergency storage expansion initiated  
**05:30 UTC** - Temporary cleanup of old logs (freed 2TB)  
**06:00 UTC** - S3 bucket capacity increased to 75TB  
**06:30 UTC** - Backup jobs resumed successfully  
**07:00 UTC** - Monitoring confirms stable state  

## Impact Analysis

### Data Impact

- **Backup Failures:** 3 backup jobs failed
- **Data at Risk:** 12 hours of incremental backups missing
- **Affected Systems:** All production databases
- **Recovery Impact:** RPO increased from 1 hour to 12 hours temporarily

### Business Impact

- **Compliance Risk:** Backup retention policy violated
- **Data Loss Risk:** Potential 12-hour data loss window
- **Audit Impact:** May affect SOC 2 compliance
- **Financial Impact:** Estimated $15,000 in emergency expansion costs

## Root Cause Analysis

### Primary Cause

Storage capacity planning did not account for accelerated data growth rate. Actual growth was 2.1TB/week vs projected 1.2TB/week.

### Contributing Factors

1. **Capacity Planning:** Projections based on outdated growth rates
2. **Monitoring:** No proactive alerts for storage trending toward capacity
3. **Log Retention:** Excessive log retention (180 days vs policy of 90 days)
4. **Backup Strategy:** No lifecycle policies to archive old backups
5. **Growth Tracking:** Manual capacity reviews only quarterly

### Root Cause Chain

1. **Why did backups fail?**  
   S3 bucket reached 96% capacity

2. **Why was storage full?**  
   Data growth exceeded capacity planning projections

3. **Why did growth exceed projections?**  
   Projections based on 6-month-old data, didn't account for business growth

4. **Why weren't projections updated?**  
   Capacity planning reviews only done quarterly

5. **Why only quarterly?**  
   No automated capacity trending or alerting system in place

## Resolution

### Immediate Actions

1. **Emergency Expansion** (Completed 06:00 UTC)
   - Increased S3 backup bucket from 50TB to 75TB
   - Cost: $1,500/month additional

2. **Temporary Cleanup** (Completed 05:30 UTC)
   - Removed logs older than 90 days
   - Freed 2TB of space
   - Verified no compliance impact

3. **Backup Resumption** (Completed 06:30 UTC)
   - All backup jobs completed successfully
   - Verified backup integrity
   - Confirmed RPO restored to 1 hour

### Verification

- [x] Storage capacity at safe level (68%)
- [x] All backup jobs running successfully
- [x] Monitoring alerts configured
- [x] Capacity trending dashboard created
- [x] Incident documentation complete

## Lessons Learned

### What Went Well

1. **Detection:** Automated monitoring caught the issue immediately
2. **Response:** Quick identification of root cause
3. **Mitigation:** Rapid storage expansion capability
4. **Communication:** Stakeholders informed promptly
5. **Recovery:** No actual data loss occurred

### What Went Wrong

1. **Prevention:** Capacity planning didn't predict growth accurately
2. **Monitoring:** No trending alerts before reaching critical capacity
3. **Automation:** Manual capacity reviews insufficient
4. **Lifecycle:** No automated data archival policies
5. **Documentation:** Capacity planning process not well documented

## Action Items

### Immediate (Completed)

- [x] Expand S3 backup storage to 75TB (Owner: Infrastructure, Due: 2024-03-20)
- [x] Clean up old logs (Owner: Infrastructure, Due: 2024-03-20)
- [x] Verify all backups successful (Owner: Infrastructure, Due: 2024-03-20)
- [x] Configure capacity alerts (Owner: Monitoring, Due: 2024-03-20)

### Short-term (In Progress)

- [ ] Implement S3 lifecycle policies (Owner: Infrastructure, Due: 2024-03-27)
- [ ] Create capacity trending dashboard (Owner: Monitoring, Due: 2024-03-25)
- [ ] Update capacity planning process (Owner: Infrastructure Manager, Due: 2024-03-29)
- [ ] Implement automated log rotation (Owner: Infrastructure, Due: 2024-04-05)

### Long-term (Planned)

- [ ] Implement predictive capacity alerting (Owner: Infrastructure, Due: 2024-04-30)
- [ ] Automate capacity planning reviews (Owner: Infrastructure, Due: 2024-05-15)
- [ ] Implement tiered storage strategy (Owner: Infrastructure, Due: 2024-06-30)
- [ ] Deploy automated data archival (Owner: Infrastructure, Due: 2024-05-31)

## Prevention Measures

### Process Improvements

1. **Capacity Planning:**
   - Monthly capacity reviews (vs quarterly)
   - Automated growth rate calculations
   - Predictive alerting at 80% capacity
   - Quarterly capacity planning updates

2. **Monitoring:**
   - Real-time capacity trending
   - Alerts at 80%, 85%, 90% thresholds
   - Weekly capacity reports
   - Automated anomaly detection

3. **Data Management:**
   - Implement lifecycle policies
   - Automated log rotation
   - Regular cleanup jobs
   - Archive old data to Glacier

### Technical Improvements

1. **Automation:**
   - Automated capacity expansion (when safe)
   - Scheduled cleanup jobs
   - Lifecycle policy enforcement
   - Capacity forecasting tools

2. **Monitoring:**
   - Grafana dashboard for capacity trending
   - PagerDuty integration for capacity alerts
   - Weekly capacity reports
   - Growth rate tracking

3. **Architecture:**
   - Tiered storage strategy
   - Automated archival to Glacier
   - Compression for old data
   - Deduplication where applicable

## Financial Impact

### Direct Costs

- Emergency Storage Expansion: $1,500/month
- Engineering Time: $4,000 (8 hours × $500/hour)
- **Total Direct Cost:** $5,500 (first month)

### Ongoing Costs

- Additional Storage: $1,500/month
- Monitoring Tools: $200/month
- **Total Ongoing:** $1,700/month

### Risk Mitigation Value

- Prevented Data Loss: Priceless
- Avoided Compliance Violations: $50,000+
- Maintained Customer Trust: Unquantified

## Recommendations

### Immediate Recommendations

1. Implement S3 lifecycle policies to automatically archive old backups
2. Set up automated capacity trending and alerting
3. Update capacity planning process to monthly reviews
4. Document storage growth patterns and projections

### Strategic Recommendations

1. Implement predictive capacity planning using ML
2. Deploy automated tiered storage strategy
3. Establish data retention governance
4. Create capacity planning playbook

## Communication

### Internal Communication

- Incident channel: #incident-2024-102
- Email: engineering@globaltech.com
- Status updates: Hourly during mitigation
- Post-mortem: Scheduled for 2024-03-22

### Stakeholder Notification

- Infrastructure Team: Immediate
- Engineering Management: 03:15 UTC
- Finance Team: 09:00 UTC (cost impact)
- Compliance Team: 10:00 UTC (policy violation)

### No Customer Impact

This incident did not directly impact customers, so no external communication was required. However, the potential for data loss was communicated internally to relevant stakeholders.

## Approval

**Incident Commander:** Jane Smith  
**Technical Lead:** Bob Johnson  
**Reviewed By:** John Doe, VP of Engineering  
**Approved By:** Jane Smith, CISO  
**Date:** March 21, 2024

---

**Post-Mortem Meeting:** March 22, 2024, 15:00 UTC  
**Attendees:** Infrastructure Team, Engineering Management, Finance

*This document contains confidential incident information.*
EOF

# Create root-cause-analysis-template.md
cat > "$BASE_DIR/incidents/root-cause-analysis-template.md" << 'EOF'
# Root Cause Analysis Template

## Incident Information

**Incident ID:** [INC-YYYY-NNN]  
**Title:** [Brief description]  
**Date:** [YYYY-MM-DD]  
**Severity:** [P1/P2/P3/P4]  
**Status:** [Investigating/Resolved/Closed]  
**Incident Commander:** [Name]  
**Technical Lead:** [Name]

## Executive Summary

[2-3 sentence summary of what happened, impact, and resolution]

## Timeline

### Detection
- **[HH:MM UTC]** - [Event description]

### Investigation
- **[HH:MM UTC]** - [Event description]

### Mitigation
- **[HH:MM UTC]** - [Event description]

### Resolution
- **[HH:MM UTC]** - [Event description]

## Impact Analysis

### Customer Impact
- **Affected Customers:** [Number/Percentage]
- **Service Degradation:** [Description]
- **Duration:** [Time period]
- **Geographic Scope:** [Regions affected]

### System Impact
- **Affected Systems:** [List]
- **Unaffected Systems:** [List]
- **Data Impact:** [Any data loss/corruption]

### Business Impact
- **Revenue Impact:** $[Amount]
- **SLA Impact:** [Yes/No, details]
- **Reputation Impact:** [Description]

## Root Cause Analysis

### Primary Cause
[Detailed description of the root cause]

### Contributing Factors
1. [Factor 1]
2. [Factor 2]
3. [Factor 3]

### Five Whys Analysis

1. **Why did [problem] occur?**  
   [Answer]

2. **Why did [answer from #1]?**  
   [Answer]

3. **Why did [answer from #2]?**  
   [Answer]

4. **Why did [answer from #3]?**  
   [Answer]

5. **Why did [answer from #4]?**  
   [Answer - This should be the root cause]

## Resolution

### Actions Taken
1. [Action 1] - [Timestamp]
2. [Action 2] - [Timestamp]
3. [Action 3] - [Timestamp]

### Verification Steps
- [ ] [Verification item 1]
- [ ] [Verification item 2]
- [ ] [Verification item 3]

## Lessons Learned

### What Went Well
1. [Item 1]
2. [Item 2]
3. [Item 3]

### What Went Wrong
1. [Item 1]
2. [Item 2]
3. [Item 3]

### What We Learned
1. [Learning 1]
2. [Learning 2]
3. [Learning 3]

## Action Items

### Immediate (0-7 days)
- [ ] [Action] (Owner: [Name], Due: [Date])
- [ ] [Action] (Owner: [Name], Due: [Date])

### Short-term (7-30 days)
- [ ] [Action] (Owner: [Name], Due: [Date])
- [ ] [Action] (Owner: [Name], Due: [Date])

### Long-term (30+ days)
- [ ] [Action] (Owner: [Name], Due: [Date])
- [ ] [Action] (Owner: [Name], Due: [Date])

## Prevention Measures

### Process Improvements
1. [Improvement 1]
2. [Improvement 2]
3. [Improvement 3]

### Technical Improvements
1. [Improvement 1]
2. [Improvement 2]
3. [Improvement 3]

### Monitoring Improvements
1. [Improvement 1]
2. [Improvement 2]
3. [Improvement 3]

## Financial Impact

### Direct Costs
- [Cost item 1]: $[Amount]
- [Cost item 2]: $[Amount]
- **Total Direct Cost:** $[Amount]

### Indirect Costs
- [Cost item 1]: $[Amount]
- [Cost item 2]: $[Amount]
- **Total Indirect Cost:** $[Amount]

**Total Estimated Impact:** $[Amount]

## Communication

### Internal Communication
- [Channel/Method]: [Details]
- [Channel/Method]: [Details]

### External Communication
- [Channel/Method]: [Details]
- [Channel/Method]: [Details]

### Customer Notification
[Details of customer communication]

## Approval

**Prepared By:** [Name, Title]  
**Reviewed By:** [Name, Title]  
**Approved By:** [Name, Title]  
**Date:** [YYYY-MM-DD]

---

**Post-Mortem Meeting:** [Date, Time]  
**Attendees:** [List]

*This document contains confidential incident information.*
EOF

echo "All incident reports and SLA documentation created successfully!"
