#!/bin/bash

BASE_DIR="module-2-infrastructure"

# Create capacity-planning.md
cat > "$BASE_DIR/docs/capacity-planning.md" << 'EOF'
# Capacity Planning Report

**Report Date:** March 20, 2024  
**Planning Period:** Q2-Q4 2024  
**Prepared By:** Infrastructure Team

## Executive Summary

This document provides capacity planning analysis and recommendations for GlobalTech Enterprise infrastructure for the next 9 months based on current utilization trends and projected growth.

## Current State Analysis

### Compute Resources

| Tier | Current Servers | Avg CPU % | Avg Memory % | Peak CPU % | Peak Memory % |
|------|----------------|-----------|--------------|------------|---------------|
| Web | 5 | 68% | 72% | 94% | 88% |
| Application | 6 | 75% | 78% | 92% | 91% |
| Database | 2 | 72% | 85% | 88% | 96% |

**Analysis:**
- Web tier approaching capacity during peak hours (>90% CPU)
- Application tier consistently above 75% utilization
- Database memory utilization critical (>85% sustained)
- Current infrastructure can support ~15% additional load

### Storage Capacity

| Storage Type | Total (TB) | Used (TB) | Used % | Growth Rate (TB/week) |
|--------------|------------|-----------|--------|----------------------|
| EBS Volumes | 2.0 | 1.7 | 85% | 0.05 |
| EFS | 5.0 | 4.2 | 84% | 0.08 |
| S3 Data | 100 | 85 | 85% | 0.8 |
| S3 Backups | 50 | 48 | 96% | 0.3 |
| Database | 1.0 | 0.9 | 90% | 0.04 |

**Critical Findings:**
- S3 backup bucket at 96% capacity - **IMMEDIATE ACTION REQUIRED**
- Database storage at 90% - expansion needed within 2 weeks
- All storage types growing faster than projected

### Network Bandwidth

| Connection | Capacity | Avg Utilization | Peak Utilization |
|------------|----------|-----------------|------------------|
| Internet | 10 Gbps | 4.2 Gbps (42%) | 8.7 Gbps (87%) |
| VPN Dallas | 1 Gbps | 450 Mbps (45%) | 850 Mbps (85%) |
| VPN London | 500 Mbps | 180 Mbps (36%) | 420 Mbps (84%) |
| Direct Connect | 10 Gbps | 2.1 Gbps (21%) | 5.2 Gbps (52%) |

## Growth Projections

### Historical Growth Analysis

**Last 6 Months:**
- User base: +35%
- Transaction volume: +42%
- Data storage: +38%
- API calls: +45%

**Projected Growth (Next 9 Months):**
- User base: +40%
- Transaction volume: +50%
- Data storage: +45%
- API calls: +55%

### Capacity Requirements by Quarter

#### Q2 2024 (Apr-Jun)

**Compute:**
- Web tier: Add 2 servers (total: 7)
- Application tier: Add 2 servers (total: 8)
- Database: Upgrade to larger instance class

**Storage:**
- Expand S3 backup bucket to 75TB
- Add 500GB to database storage
- Increase EFS capacity to 7TB

**Network:**
- Upgrade Dallas VPN to 2 Gbps
- Monitor internet bandwidth

**Estimated Cost:** $45,000/month additional

#### Q3 2024 (Jul-Sep)

**Compute:**
- Web tier: Add 1 server (total: 8)
- Application tier: Add 2 servers (total: 10)
- Add read replica in eu-west-1

**Storage:**
- Expand S3 data bucket to 150TB
- Add 1TB to database storage
- Implement data archival strategy

**Network:**
- Upgrade London VPN to 1 Gbps
- Add second Direct Connect circuit

**Estimated Cost:** $62,000/month additional

#### Q4 2024 (Oct-Dec)

**Compute:**
- Web tier: Add 2 servers (total: 10)
- Application tier: Add 2 servers (total: 12)
- Deploy multi-region architecture

**Storage:**
- Expand S3 data bucket to 200TB
- Implement tiered storage strategy
- Add 2TB to database storage

**Network:**
- Upgrade internet to 20 Gbps
- Implement CDN optimization

**Estimated Cost:** $85,000/month additional

## Recommendations

### Immediate Actions (Next 30 Days)

1. **Expand S3 Backup Bucket** (Priority: CRITICAL)
   - Increase capacity to 75TB
   - Implement lifecycle policies
   - Cost: $1,500/month

2. **Database Storage Expansion** (Priority: HIGH)
   - Add 500GB storage
   - Enable auto-scaling
   - Cost: $500/month

3. **Add Application Servers** (Priority: HIGH)
   - Deploy 2 additional app servers
   - Implement auto-scaling
   - Cost: $3,000/month

### Short-term Actions (30-90 Days)

1. **Implement Auto-Scaling**
   - Configure predictive scaling
   - Set up scheduled scaling
   - Reduce manual intervention

2. **Optimize Storage**
   - Implement data lifecycle policies
   - Archive old data to Glacier
   - Clean up unused resources

3. **Network Optimization**
   - Upgrade VPN connections
   - Implement traffic shaping
   - Optimize CDN configuration

### Long-term Strategy (90+ Days)

1. **Multi-Region Deployment**
   - Deploy to eu-west-1
   - Implement global load balancing
   - Improve latency for European users

2. **Kubernetes Migration**
   - Containerize applications
   - Implement EKS clusters
   - Improve resource utilization

3. **Cost Optimization**
   - Reserved instance purchases
   - Spot instance utilization
   - Right-sizing analysis

## Risk Assessment

### High Risks

1. **Storage Capacity Exhaustion**
   - Impact: Service disruption
   - Probability: High (within 6 weeks)
   - Mitigation: Immediate expansion

2. **Database Performance Degradation**
   - Impact: Slow response times
   - Probability: Medium
   - Mitigation: Upgrade instance, add read replicas

3. **Network Bandwidth Saturation**
   - Impact: Connectivity issues
   - Probability: Medium (during peak events)
   - Mitigation: Upgrade connections, implement CDN

### Medium Risks

1. **Compute Resource Exhaustion**
   - Impact: Unable to scale
   - Probability: Medium
   - Mitigation: Implement auto-scaling

2. **Backup Failures**
   - Impact: Data loss risk
   - Probability: Low
   - Mitigation: Expand backup storage

## Budget Forecast

| Quarter | Infrastructure Cost | Growth Cost | Total Cost | YoY Change |
|---------|-------------------|-------------|------------|------------|
| Q1 2024 | $450,000 | $0 | $450,000 | Baseline |
| Q2 2024 | $450,000 | $45,000 | $495,000 | +10% |
| Q3 2024 | $450,000 | $107,000 | $557,000 | +24% |
| Q4 2024 | $450,000 | $192,000 | $642,000 | +43% |

**Annual Projection:** $2.144M (vs $1.8M current run rate)

## Monitoring and Review

### Key Metrics to Track

1. **Utilization Metrics**
   - CPU utilization by tier
   - Memory utilization by tier
   - Storage capacity by type
   - Network bandwidth utilization

2. **Performance Metrics**
   - Response time (p95, p99)
   - Error rates
   - Throughput (requests/second)
   - Database query performance

3. **Business Metrics**
   - Active users
   - Transaction volume
   - Data growth rate
   - API call volume

### Review Schedule

- **Weekly:** Utilization review
- **Monthly:** Capacity planning update
- **Quarterly:** Strategic planning review
- **Annually:** Multi-year capacity planning

## Approval

**Prepared By:** Infrastructure Team  
**Reviewed By:** John Doe, VP of Engineering  
**Approved By:** Sarah Johnson, CEO  
**Approval Date:** March 20, 2024

---

*This document contains confidential business information.*
EOF

# Create disaster-recovery-plan.md
cat > "$BASE_DIR/docs/disaster-recovery-plan.md" << 'EOF'
# Disaster Recovery Plan

**Document Version:** 3.2  
**Last Updated:** March 20, 2024  
**Last Tested:** February 15, 2024  
**Owner:** Infrastructure Team

## 1. Overview

### 1.1 Purpose

This Disaster Recovery (DR) Plan outlines procedures to recover GlobalTech Enterprise IT infrastructure and services in the event of a disaster.

### 1.2 Scope

This plan covers:
- AWS cloud infrastructure
- On-premises data centers (Dallas, London, Singapore)
- Network connectivity
- Critical applications and databases
- Data backup and recovery

### 1.3 Objectives

- **Recovery Time Objective (RTO):** 4 hours
- **Recovery Point Objective (RPO):** 1 hour
- **Availability Target:** 99.95% uptime

## 2. Disaster Scenarios

### 2.1 Scenario Classifications

| Scenario | Severity | RTO | RPO | Likelihood |
|----------|----------|-----|-----|------------|
| Single server failure | Low | 30 min | 0 | High |
| Availability zone failure | Medium | 2 hours | 15 min | Medium |
| Region failure | High | 4 hours | 1 hour | Low |
| Data center failure | High | 4 hours | 1 hour | Low |
| Cyber attack | Critical | 8 hours | 4 hours | Medium |
| Natural disaster | Critical | 24 hours | 4 hours | Low |

### 2.2 Disaster Triggers

**Automatic Failover Triggers:**
- Multiple server failures in same tier
- Availability zone unavailable
- Network connectivity loss >5 minutes
- Database replication lag >1 hour

**Manual Failover Triggers:**
- Regional AWS outage
- Data center evacuation
- Security breach requiring isolation
- Planned DR test

## 3. Recovery Procedures

### 3.1 Single Server Failure

**Detection:**
- Automated health checks fail
- Monitoring alerts triggered
- Load balancer marks instance unhealthy

**Recovery Steps:**
1. Verify failure (2 minutes)
2. Remove from load balancer (automatic)
3. Launch replacement instance (5 minutes)
4. Configure and deploy application (15 minutes)
5. Add to load balancer (2 minutes)
6. Verify functionality (5 minutes)

**Total Time:** ~30 minutes

### 3.2 Availability Zone Failure

**Detection:**
- Multiple instances in AZ fail
- AWS service health dashboard
- Network connectivity loss

**Recovery Steps:**
1. Confirm AZ failure (5 minutes)
2. Redirect traffic to healthy AZs (automatic)
3. Scale up instances in healthy AZs (10 minutes)
4. Verify capacity and performance (15 minutes)
5. Monitor for AZ recovery (ongoing)
6. Rebalance when AZ recovers (30 minutes)

**Total Time:** ~2 hours

### 3.3 AWS Region Failure

**Detection:**
- Region-wide service disruption
- Multiple AZ failures
- AWS status page confirmation

**Recovery Steps:**
1. **Declare Disaster** (15 minutes)
   - Notify stakeholders
   - Activate DR team
   - Document incident

2. **Failover to DR Region** (60 minutes)
   - Update Route53 to point to DR region
   - Activate standby instances
   - Promote read replica to primary
   - Verify database integrity

3. **Application Recovery** (90 minutes)
   - Deploy applications to DR region
   - Configure load balancers
   - Update DNS records
   - Verify application functionality

4. **Verification** (45 minutes)
   - Test critical user flows
   - Verify data integrity
   - Monitor performance
   - Communicate status

**Total Time:** ~4 hours

### 3.4 Data Center Failure

**Detection:**
- Loss of connectivity to data center
- Physical security alerts
- Facility management notification

**Recovery Steps:**
1. **Assessment** (30 minutes)
   - Determine scope of failure
   - Identify affected systems
   - Activate DR team

2. **Failover to Cloud** (120 minutes)
   - Activate VPN to alternate site
   - Restore from backups if needed
   - Redirect traffic to AWS
   - Verify connectivity

3. **Service Restoration** (90 minutes)
   - Bring up critical services
   - Restore data from backups
   - Verify functionality
   - Monitor performance

**Total Time:** ~4 hours

### 3.5 Cyber Attack / Ransomware

**Detection:**
- Security monitoring alerts
- Unusual system behavior
- User reports
- Antivirus/EDR alerts

**Recovery Steps:**
1. **Containment** (30 minutes)
   - Isolate affected systems
   - Disable compromised accounts
   - Block malicious IPs
   - Preserve evidence

2. **Assessment** (60 minutes)
   - Determine attack scope
   - Identify compromised data
   - Assess backup integrity
   - Engage security team

3. **Eradication** (120 minutes)
   - Remove malware
   - Patch vulnerabilities
   - Reset credentials
   - Rebuild compromised systems

4. **Recovery** (180 minutes)
   - Restore from clean backups
   - Verify data integrity
   - Restore services gradually
   - Monitor for reinfection

**Total Time:** ~8 hours

## 4. Backup Strategy

### 4.1 Backup Schedule

| Data Type | Frequency | Retention | Location |
|-----------|-----------|-----------|----------|
| Database (Full) | Daily | 30 days | S3 + DR site |
| Database (Incremental) | Hourly | 7 days | S3 |
| Application Data | Daily | 30 days | S3 + DR site |
| Configuration | On change | 90 days | Git + S3 |
| System State | Weekly | 30 days | S3 |
| Logs | Real-time | 90 days | S3 + CloudWatch |

### 4.2 Backup Verification

- **Automated Tests:** Daily
- **Manual Verification:** Weekly
- **Full Restore Test:** Monthly
- **DR Drill:** Quarterly

### 4.3 Backup Locations

**Primary:** S3 us-east-1 (encrypted)  
**Secondary:** S3 us-west-2 (cross-region replication)  
**Tertiary:** Singapore data center (offline backups)

## 5. Communication Plan

### 5.1 Notification Tree

```
Disaster Detected
    |
    v
[On-Call Engineer]
    |
    +-- [Infrastructure Manager] (15 min)
    +-- [CTO] (30 min)
    +-- [CEO] (if critical) (60 min)
    |
    v
[DR Team Activation]
    |
    +-- Infrastructure Team
    +-- Application Team
    +-- Database Team
    +-- Security Team
    +-- Communications Team
```

### 5.2 Stakeholder Communication

**Internal:**
- Slack #incident-response channel
- Email to engineering@globaltech.com
- Status page updates

**External:**
- Customer email notifications
- Status page (status.globaltech.com)
- Social media updates
- Support ticket responses

### 5.3 Communication Templates

**Initial Notification:**
```
Subject: [INCIDENT] Service Disruption - [Date/Time]

We are currently experiencing [description of issue].

Impact: [affected services]
Status: [investigating/mitigating/resolved]
ETA: [estimated resolution time]

Updates will be provided every 30 minutes.
```

**Resolution Notification:**
```
Subject: [RESOLVED] Service Disruption - [Date/Time]

The service disruption has been resolved.

Duration: [total downtime]
Root Cause: [brief description]
Resolution: [actions taken]

A detailed post-mortem will be published within 48 hours.
```

## 6. DR Team Roles and Responsibilities

### 6.1 Incident Commander
- Overall coordination
- Decision making authority
- Stakeholder communication
- Resource allocation

### 6.2 Technical Lead
- Technical recovery execution
- Team coordination
- Progress tracking
- Technical decisions

### 6.3 Database Administrator
- Database recovery
- Data integrity verification
- Replication management
- Performance tuning

### 6.4 Network Engineer
- Network connectivity
- DNS management
- VPN configuration
- Traffic routing

### 6.5 Security Engineer
- Security assessment
- Access control
- Threat monitoring
- Compliance verification

### 6.6 Communications Lead
- Stakeholder updates
- Status page management
- Customer communication
- Documentation

## 7. Recovery Validation

### 7.1 Validation Checklist

- [ ] All critical services operational
- [ ] Database integrity verified
- [ ] Application functionality tested
- [ ] Performance within acceptable range
- [ ] Security controls in place
- [ ] Monitoring and alerting active
- [ ] Backup systems operational
- [ ] Documentation updated

### 7.2 Critical Service Tests

1. **User Authentication**
   - Login functionality
   - MFA working
   - Session management

2. **Core Business Functions**
   - Order processing
   - Payment processing
   - Inventory management

3. **Data Integrity**
   - Database consistency checks
   - Transaction log verification
   - Backup validation

4. **Performance**
   - Response time <2 seconds
   - Error rate <0.1%
   - Throughput >1000 req/sec

## 8. Post-Disaster Activities

### 8.1 Immediate (0-24 hours)

- Continue monitoring
- Document timeline
- Preserve evidence
- Communicate resolution

### 8.2 Short-term (1-7 days)

- Conduct post-mortem
- Identify root cause
- Document lessons learned
- Update procedures

### 8.3 Long-term (7-30 days)

- Implement improvements
- Update DR plan
- Conduct training
- Review and test changes

## 9. DR Testing Schedule

### 9.1 Test Types

**Tabletop Exercise:** Monthly
- Review procedures
- Discuss scenarios
- Identify gaps

**Partial Failover:** Quarterly
- Test specific components
- Verify procedures
- Minimal impact

**Full DR Drill:** Annually
- Complete failover
- All teams involved
- Comprehensive testing

### 9.2 Last Test Results

**Date:** February 15, 2024  
**Type:** Full DR Drill  
**Result:** Successful  
**RTO Achieved:** 3 hours 45 minutes  
**RPO Achieved:** 45 minutes  
**Issues Found:** 3 minor documentation gaps  
**Action Items:** 5 improvements identified

## 10. Contact Information

### 10.1 DR Team

| Role | Name | Phone | Email |
|------|------|-------|-------|
| Incident Commander | John Doe | +1-555-0101 | john.doe@globaltech.com |
| Technical Lead | Jane Smith | +1-555-0102 | jane.smith@globaltech.com |
| DBA Lead | Bob Johnson | +1-555-0103 | bob.johnson@globaltech.com |
| Network Lead | Alice Brown | +1-555-0104 | alice.brown@globaltech.com |

### 10.2 Vendors

| Vendor | Service | Contact | Phone |
|--------|---------|---------|-------|
| AWS | Cloud Infrastructure | TAM | +1-800-AWS-SUPPORT |
| Palo Alto | Firewall | Support | +1-866-320-4788 |
| F5 | Load Balancer | Support | +1-888-882-4447 |

## 11. Document Control

**Version History:**

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 3.2 | 2024-03-20 | Infrastructure Team | Updated RTO/RPO targets |
| 3.1 | 2024-02-15 | Infrastructure Team | Post-drill updates |
| 3.0 | 2024-01-10 | Infrastructure Team | Major revision |

**Next Review Date:** June 20, 2024

---

*This document contains confidential disaster recovery procedures.*
EOF

echo "Documentation files created successfully!"
