# Infrastructure Scenario: GlobalTech Enterprise

## Company Background

**GlobalTech Enterprise** is a multinational technology company with operations across North America, Europe, and Asia. The company provides SaaS solutions to over 10,000 enterprise customers and processes millions of transactions daily.

## Current Infrastructure

### Cloud Infrastructure (AWS)
- **Regions:** us-east-1, us-west-2, eu-west-1, ap-southeast-1
- **EC2 Instances:** 312 instances across multiple availability zones
- **Instance Types:** Mix of t3.medium to r5.4xlarge
- **Storage:** 150TB across S3, EBS, and EFS
- **Databases:** 12 RDS instances (PostgreSQL, MySQL)
- **Load Balancers:** 8 Application Load Balancers
- **Auto Scaling Groups:** 15 ASGs for dynamic workloads

### On-Premises Data Centers
- **Location 1 (Primary):** Dallas, TX - 120 servers
- **Location 2 (Secondary):** London, UK - 50 servers
- **Location 3 (DR Site):** Singapore - 30 servers
- **Total Capacity:** 200 physical servers, 800TB storage

### Network Infrastructure
- **VPN Tunnels:** 6 site-to-site VPNs connecting data centers
- **Direct Connect:** 2x 10Gbps connections to AWS
- **Firewall Rules:** 150+ rules across multiple security groups
- **DNS Zones:** 25 domains with 500+ records
- **Load Balancers:** 5 F5 BIG-IP appliances on-premises

## Recent Events Timeline

### Week 1: Capacity Warnings
**Date:** March 10-16, 2024

- CPU utilization on web tier servers exceeded 85% during peak hours
- Memory pressure alerts triggered on database servers
- Storage capacity warnings on backup volumes (>90% full)
- Auto-scaling groups hitting maximum instance limits

**Impact:**
- Increased response times (p95 latency up 40%)
- 3 customer-reported performance issues
- Backup jobs failing due to insufficient storage

### Week 2: Security Vulnerability Discovery
**Date:** March 17-23, 2024

- Quarterly vulnerability scan completed
- **Critical Findings:** 12 CVEs with CVSS scores > 7.0
- **High Findings:** 34 CVEs requiring attention
- Several servers running outdated OS versions
- Missing security patches on 45+ instances

**Key Vulnerabilities:**
- CVE-2024-1234: OpenSSL vulnerability (CVSS 9.8)
- CVE-2024-5678: Linux kernel privilege escalation (CVSS 8.4)
- CVE-2024-9012: Apache HTTP Server RCE (CVSS 7.5)

### Week 3: Network Incidents
**Date:** March 18, 2024

**Incident INC-2024-101:** Network Outage
- Duration: 2 hours 15 minutes
- Affected: London data center connectivity
- Impact: 15% of European customers experienced service disruption
- Root Cause: VPN tunnel failure due to configuration drift

**Incident INC-2024-102:** Storage Capacity Crisis
- Duration: Ongoing
- Affected: Backup systems and log aggregation
- Impact: Backup retention policy violations, log data loss
- Root Cause: Faster than projected data growth

### Week 4: Compliance Pressure
**Date:** March 20-24, 2024

- SOC 2 Type II audit scheduled for April 15, 2024
- ISO 27001 recertification due in May 2024
- Compliance team identified documentation gaps
- Missing disaster recovery test results
- Incomplete security policy documentation

## Current Challenges

### 1. Capacity Management
**Problem:** Infrastructure approaching capacity limits across multiple dimensions.

**Symptoms:**
- CPU utilization consistently >80% on 45 instances
- Memory utilization >85% on 28 instances
- Storage growth rate: 2TB/week (projected to exceed capacity in 6 weeks)
- Auto-scaling groups unable to scale further

**Business Impact:**
- Performance degradation affecting customer experience
- Risk of service outages during traffic spikes
- Inability to onboard new customers without infrastructure expansion

### 2. Security Posture
**Problem:** Multiple critical vulnerabilities and outdated systems.

**Symptoms:**
- 12 critical CVEs requiring immediate patching
- 34 high-severity vulnerabilities
- 45 instances running end-of-life OS versions
- Inconsistent security hardening across environments

**Business Impact:**
- Increased risk of security breaches
- Potential compliance violations
- Customer trust concerns
- Possible regulatory fines

### 3. Network Reliability
**Problem:** Intermittent connectivity issues and configuration drift.

**Symptoms:**
- VPN tunnel instability between data centers
- Packet loss during peak hours (0.5-2%)
- DNS resolution delays
- Load balancer health check failures

**Business Impact:**
- Service disruptions for customers
- Data replication delays
- Increased incident response workload
- SLA violations

### 4. Documentation Gaps
**Problem:** Incomplete or outdated infrastructure documentation.

**Missing/Outdated:**
- Disaster recovery runbooks
- Network topology diagrams
- Capacity planning projections
- Security hardening procedures
- Incident response playbooks

**Business Impact:**
- Slower incident resolution
- Knowledge silos and single points of failure
- Compliance audit risks
- Difficulty onboarding new team members

## Infrastructure Metrics (Last 30 Days)

### Compute Resources
- Average CPU Utilization: 68% (up from 52% previous month)
- Peak CPU Utilization: 94% (web tier)
- Average Memory Utilization: 72% (up from 58%)
- Instance Count Growth: +15% month-over-month

### Storage
- Total Storage Used: 142TB of 150TB (94.7%)
- Growth Rate: 2.1TB/week
- Backup Storage: 48TB of 50TB (96%)
- S3 Storage: 85TB (growing 800GB/week)

### Network
- Average Bandwidth Utilization: 4.2Gbps
- Peak Bandwidth: 8.7Gbps
- Packet Loss: 0.3% average, 2.1% peak
- VPN Tunnel Uptime: 98.2% (below 99.5% SLA)

### Availability
- Overall Uptime: 99.7% (target: 99.95%)
- Incidents: 8 (3 critical, 5 high)
- Mean Time to Detect (MTTD): 12 minutes
- Mean Time to Resolve (MTTR): 45 minutes

## Stakeholder Expectations

### CTO
- Ensure 99.95% uptime SLA compliance
- Complete security vulnerability remediation within 30 days
- Provide capacity planning roadmap for next 12 months

### CISO
- Pass SOC 2 audit with zero findings
- Remediate all critical vulnerabilities within 2 weeks
- Implement automated security compliance monitoring

### VP of Engineering
- Eliminate performance bottlenecks
- Reduce incident response time by 30%
- Improve infrastructure documentation

### Finance
- Optimize cloud costs (current: $450K/month)
- Justify capacity expansion with ROI analysis
- Reduce waste from over-provisioned resources

## Your Mission

As the lead infrastructure engineer, you need to:

1. **Assess** the current state of the infrastructure
2. **Identify** critical issues requiring immediate attention
3. **Prioritize** remediation efforts based on business impact
4. **Plan** capacity expansion and security improvements
5. **Document** findings and recommendations for leadership

Use Bob to help you navigate this complex infrastructure, analyze the data, troubleshoot issues, and develop actionable plans.

## Success Metrics

- Reduce critical alerts by 50%
- Achieve <80% resource utilization across all systems
- Remediate all critical security vulnerabilities
- Update all infrastructure documentation
- Pass compliance audits with zero findings
- Maintain 99.95% uptime SLA

---

**Time to get started!** Use Bob to explore the infrastructure and tackle these challenges.