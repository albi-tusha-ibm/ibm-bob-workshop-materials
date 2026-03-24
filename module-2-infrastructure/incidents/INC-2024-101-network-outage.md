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
