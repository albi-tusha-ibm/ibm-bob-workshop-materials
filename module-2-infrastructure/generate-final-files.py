#!/usr/bin/env python3
"""
Generate final infrastructure module files: security, documentation, and incidents
"""

import json
import csv
from datetime import datetime

BASE_DIR = "module-2-infrastructure"

def create_vulnerability_scan():
    """Generate vulnerability scan results JSON"""
    filename = f"{BASE_DIR}/security/vulnerability-scan-results.json"
    
    vulnerabilities = {
        "scan_metadata": {
            "scan_id": "SCAN-2024-03-20-001",
            "scan_date": "2024-03-20T10:30:00Z",
            "scanner": "Nessus Professional 10.5.0",
            "scan_duration_minutes": 145,
            "hosts_scanned": 312,
            "total_vulnerabilities": 89
        },
        "summary": {
            "critical": 12,
            "high": 34,
            "medium": 28,
            "low": 15,
            "informational": 0
        },
        "critical_vulnerabilities": [
            {
                "cve_id": "CVE-2024-1234",
                "title": "OpenSSL Remote Code Execution Vulnerability",
                "cvss_score": 9.8,
                "severity": "CRITICAL",
                "affected_hosts": ["web-01", "web-02", "app-01", "app-03"],
                "description": "A critical vulnerability in OpenSSL allows remote attackers to execute arbitrary code",
                "remediation": "Update OpenSSL to version 3.0.13 or later",
                "references": ["https://nvd.nist.gov/vuln/detail/CVE-2024-1234"],
                "first_detected": "2024-03-20",
                "status": "OPEN"
            },
            {
                "cve_id": "CVE-2024-5678",
                "title": "Linux Kernel Privilege Escalation",
                "cvss_score": 8.4,
                "severity": "CRITICAL",
                "affected_hosts": ["app-02", "app-04", "app-05", "db-primary"],
                "description": "Local privilege escalation vulnerability in Linux kernel",
                "remediation": "Update kernel to version 5.15.0-97 or later",
                "references": ["https://nvd.nist.gov/vuln/detail/CVE-2024-5678"],
                "first_detected": "2024-03-20",
                "status": "OPEN"
            },
            {
                "cve_id": "CVE-2024-9012",
                "title": "Apache HTTP Server Remote Code Execution",
                "cvss_score": 7.5,
                "severity": "CRITICAL",
                "affected_hosts": ["web-03", "web-04", "web-05"],
                "description": "RCE vulnerability in Apache HTTP Server mod_proxy",
                "remediation": "Update Apache to version 2.4.58 or later",
                "references": ["https://nvd.nist.gov/vuln/detail/CVE-2024-9012"],
                "first_detected": "2024-03-20",
                "status": "OPEN"
            },
            {
                "cve_id": "CVE-2023-8765",
                "title": "PostgreSQL Authentication Bypass",
                "cvss_score": 9.1,
                "severity": "CRITICAL",
                "affected_hosts": ["db-primary", "db-replica"],
                "description": "Authentication bypass in PostgreSQL SCRAM authentication",
                "remediation": "Update PostgreSQL to version 15.6 or later",
                "references": ["https://nvd.nist.gov/vuln/detail/CVE-2023-8765"],
                "first_detected": "2024-03-18",
                "status": "IN_PROGRESS"
            }
        ],
        "high_vulnerabilities": [
            {
                "cve_id": "CVE-2024-3456",
                "title": "Sudo Privilege Escalation",
                "cvss_score": 7.8,
                "severity": "HIGH",
                "affected_hosts": ["web-01", "web-02", "app-01", "app-02", "app-03"],
                "description": "Heap-based buffer overflow in sudo",
                "remediation": "Update sudo to version 1.9.15 or later",
                "status": "OPEN"
            },
            {
                "cve_id": "CVE-2024-4567",
                "title": "OpenSSH Denial of Service",
                "cvss_score": 7.5,
                "severity": "HIGH",
                "affected_hosts": ["ALL"],
                "description": "DoS vulnerability in OpenSSH server",
                "remediation": "Update OpenSSH to version 9.6p1 or later",
                "status": "OPEN"
            }
        ],
        "compliance_issues": [
            {
                "issue": "Outdated OS versions",
                "affected_count": 15,
                "severity": "HIGH",
                "description": "15 servers running end-of-life OS versions"
            },
            {
                "issue": "Missing security patches",
                "affected_count": 45,
                "severity": "MEDIUM",
                "description": "45 servers missing critical security patches"
            },
            {
                "issue": "Weak SSL/TLS configuration",
                "affected_count": 8,
                "severity": "MEDIUM",
                "description": "8 servers supporting deprecated TLS 1.0/1.1"
            }
        ],
        "recommendations": [
            "Prioritize patching of critical CVEs within 7 days",
            "Implement automated patch management",
            "Upgrade end-of-life operating systems",
            "Disable TLS 1.0 and 1.1 across all services",
            "Conduct monthly vulnerability scans",
            "Implement vulnerability management workflow"
        ]
    }
    
    with open(filename, 'w') as f:
        json.dump(vulnerabilities, f, indent=2)
    
    print(f"Created {filename}")

def create_compliance_report():
    """Generate compliance report"""
    filename = f"{BASE_DIR}/security/compliance-report.md"
    
    content = """# Compliance Report - GlobalTech Enterprise

**Report Date:** March 20, 2024  
**Reporting Period:** Q1 2024  
**Prepared By:** Security & Compliance Team

## Executive Summary

This report provides an overview of GlobalTech Enterprise's compliance status with SOC 2 Type II and ISO 27001 standards for Q1 2024.

### Overall Compliance Status

| Framework | Status | Compliance % | Findings |
|-----------|--------|--------------|----------|
| SOC 2 Type II | In Progress | 87% | 8 gaps identified |
| ISO 27001 | Compliant | 94% | 3 minor findings |

## SOC 2 Type II Compliance

### Trust Service Criteria

#### Security (CC6)
- **Status:** Partially Compliant (85%)
- **Findings:**
  - 12 critical vulnerabilities require remediation
  - Patch management process needs improvement
  - Multi-factor authentication not enforced for all admin accounts

#### Availability (A1)
- **Status:** Compliant (98%)
- **Findings:**
  - Uptime SLA met: 99.7% (target: 99.5%)
  - 2 minor incidents impacted availability
  - Disaster recovery plan tested successfully

#### Processing Integrity (PI1)
- **Status:** Compliant (92%)
- **Findings:**
  - Data validation controls in place
  - Transaction logging comprehensive
  - Minor gaps in error handling documentation

#### Confidentiality (C1)
- **Status:** Partially Compliant (88%)
- **Findings:**
  - Encryption at rest implemented
  - Encryption in transit needs improvement (TLS 1.0/1.1 still enabled)
  - Data classification policy requires update

#### Privacy (P1)
- **Status:** Compliant (95%)
- **Findings:**
  - Privacy policy updated and published
  - Data retention policies enforced
  - Minor documentation gaps

### Action Items

1. **Critical (Due: April 15, 2024)**
   - Remediate all critical CVEs
   - Enforce MFA for all administrative access
   - Disable TLS 1.0 and 1.1

2. **High Priority (Due: May 1, 2024)**
   - Update data classification policy
   - Implement automated patch management
   - Complete security awareness training

3. **Medium Priority (Due: June 1, 2024)**
   - Update error handling documentation
   - Enhance logging and monitoring
   - Review and update access controls

## ISO 27001 Compliance

### Control Domains

#### A.5 - Information Security Policies
- **Status:** Compliant
- **Controls Implemented:** 2/2
- **Findings:** None

#### A.6 - Organization of Information Security
- **Status:** Compliant
- **Controls Implemented:** 7/7
- **Findings:** None

#### A.7 - Human Resource Security
- **Status:** Compliant
- **Controls Implemented:** 6/6
- **Findings:** Background checks completed for all new hires

#### A.8 - Asset Management
- **Status:** Partially Compliant
- **Controls Implemented:** 9/10
- **Findings:** Asset inventory needs quarterly updates

#### A.9 - Access Control
- **Status:** Partially Compliant
- **Controls Implemented:** 13/14
- **Findings:** MFA not enforced for all users

#### A.10 - Cryptography
- **Status:** Compliant
- **Controls Implemented:** 2/2
- **Findings:** Encryption standards meet requirements

#### A.12 - Operations Security
- **Status:** Compliant
- **Controls Implemented:** 14/14
- **Findings:** Backup and recovery procedures tested

#### A.13 - Communications Security
- **Status:** Partially Compliant
- **Controls Implemented:** 6/7
- **Findings:** Network segmentation needs improvement

#### A.14 - System Acquisition, Development and Maintenance
- **Status:** Compliant
- **Controls Implemented:** 13/13
- **Findings:** Secure development lifecycle in place

#### A.16 - Information Security Incident Management
- **Status:** Compliant
- **Controls Implemented:** 7/7
- **Findings:** Incident response plan tested quarterly

#### A.17 - Information Security Aspects of Business Continuity Management
- **Status:** Compliant
- **Controls Implemented:** 4/4
- **Findings:** DR plan tested successfully

#### A.18 - Compliance
- **Status:** Compliant
- **Controls Implemented:** 8/8
- **Findings:** Regular compliance reviews conducted

### Non-Conformities

1. **Minor NC-001:** Asset inventory not updated quarterly
   - **Corrective Action:** Implement automated asset discovery
   - **Due Date:** April 30, 2024

2. **Minor NC-002:** MFA not enforced for all administrative accounts
   - **Corrective Action:** Enable MFA for remaining 15 accounts
   - **Due Date:** April 15, 2024

3. **Minor NC-003:** Network segmentation documentation incomplete
   - **Corrective Action:** Update network diagrams and documentation
   - **Due Date:** May 15, 2024

## Audit Schedule

### Upcoming Audits

| Audit | Type | Scheduled Date | Auditor |
|-------|------|----------------|---------|
| SOC 2 Type II | External | April 15-19, 2024 | Deloitte |
| ISO 27001 Surveillance | External | June 10-12, 2024 | BSI |
| Internal Security | Internal | Monthly | Security Team |

## Risk Assessment

### High Risks

1. **Critical Vulnerabilities**
   - Impact: High
   - Likelihood: Medium
   - Mitigation: Accelerated patching schedule

2. **Incomplete MFA Deployment**
   - Impact: High
   - Likelihood: Low
   - Mitigation: Complete rollout by April 15

### Medium Risks

1. **Outdated TLS Versions**
   - Impact: Medium
   - Likelihood: Low
   - Mitigation: Disable TLS 1.0/1.1 by April 30

2. **Asset Inventory Gaps**
   - Impact: Medium
   - Likelihood: Medium
   - Mitigation: Implement automated discovery

## Recommendations

1. **Immediate Actions**
   - Complete critical vulnerability remediation
   - Enforce MFA across all systems
   - Disable deprecated TLS versions

2. **Short-term (30-60 days)**
   - Implement automated patch management
   - Update security policies and procedures
   - Complete security awareness training

3. **Long-term (90+ days)**
   - Enhance network segmentation
   - Implement SIEM solution
   - Conduct penetration testing

## Conclusion

GlobalTech Enterprise maintains a strong security posture with 87% SOC 2 compliance and 94% ISO 27001 compliance. The identified gaps are manageable and have clear remediation plans. With focused effort on the action items, we expect to achieve full compliance before the upcoming audits.

## Approval

**Prepared By:** Jane Smith, CISO  
**Reviewed By:** John Doe, VP of Engineering  
**Approved By:** Sarah Johnson, CEO

---

*This document contains confidential information. Distribution is restricted to authorized personnel only.*
"""
    
    with open(filename, 'w') as f:
        f.write(content)
    
    print(f"Created {filename}")

def create_patch_management_log():
    """Generate patch management log CSV"""
    filename = f"{BASE_DIR}/security/patch-management-log.csv"
    
    with open(filename, 'w', newline='') as f:
        writer = csv.writer(f)
        writer.writerow(['date', 'server', 'patch_id', 'description', 'severity', 'status', 'installed_by', 'reboot_required'])
        
        patches = [
            ['2024-03-18', 'web-01', 'KB5035857', 'Security Update for OpenSSL', 'Critical', 'Installed', 'automation', 'Yes'],
            ['2024-03-18', 'web-02', 'KB5035857', 'Security Update for OpenSSL', 'Critical', 'Installed', 'automation', 'Yes'],
            ['2024-03-17', 'app-01', 'KB5035845', 'Linux Kernel Security Update', 'Critical', 'Installed', 'automation', 'Yes'],
            ['2024-03-17', 'app-02', 'KB5035845', 'Linux Kernel Security Update', 'Critical', 'Failed', 'automation', 'Yes'],
            ['2024-03-16', 'db-primary', 'PG-2024-001', 'PostgreSQL Security Patch', 'Critical', 'Installed', 'dba_team', 'No'],
            ['2024-03-16', 'db-replica', 'PG-2024-001', 'PostgreSQL Security Patch', 'Critical', 'Installed', 'dba_team', 'No'],
            ['2024-03-15', 'web-03', 'APACHE-2024-03', 'Apache HTTP Server Update', 'High', 'Installed', 'automation', 'Yes'],
            ['2024-03-15', 'web-04', 'APACHE-2024-03', 'Apache HTTP Server Update', 'High', 'Installed', 'automation', 'Yes'],
            ['2024-03-15', 'web-05', 'APACHE-2024-03', 'Apache HTTP Server Update', 'High', 'Pending', 'automation', 'Yes'],
            ['2024-03-14', 'app-03', 'SUDO-2024-001', 'Sudo Privilege Escalation Fix', 'High', 'Installed', 'automation', 'No'],
            ['2024-03-14', 'app-04', 'SUDO-2024-001', 'Sudo Privilege Escalation Fix', 'High', 'Installed', 'automation', 'No'],
            ['2024-03-14', 'app-05', 'SUDO-2024-001', 'Sudo Privilege Escalation Fix', 'High', 'Installed', 'automation', 'No'],
            ['2024-03-13', 'web-01', 'OPENSSH-2024-02', 'OpenSSH Security Update', 'High', 'Installed', 'automation', 'Yes'],
            ['2024-03-13', 'web-02', 'OPENSSH-2024-02', 'OpenSSH Security Update', 'High', 'Installed', 'automation', 'Yes'],
            ['2024-03-12', 'app-06', 'KB5035820', 'Java Security Update', 'Medium', 'Installed', 'automation', 'No'],
            ['2024-03-11', 'bastion', 'KB5035810', 'System Security Update', 'Medium', 'Installed', 'sysadmin', 'Yes'],
            ['2024-03-10', 'prometheus', 'PROM-2024-01', 'Prometheus Security Patch', 'Low', 'Installed', 'monitoring_team', 'No'],
            ['2024-03-10', 'grafana', 'GRAF-2024-01', 'Grafana Security Update', 'Low', 'Installed', 'monitoring_team', 'No'],
        ]
        
        writer.writerows(patches)
    
    print(f"Created {filename}")

def create_security_policies():
    """Generate security policies document"""
    filename = f"{BASE_DIR}/security/security-policies.md"
    
    content = """# Security Policies and Procedures

**Document Version:** 2.1  
**Last Updated:** March 20, 2024  
**Owner:** Chief Information Security Officer (CISO)  
**Review Cycle:** Annual

## 1. Access Control Policy

### 1.1 User Access Management

**Purpose:** Ensure appropriate access controls are in place to protect information assets.

**Policy:**
- All users must have unique user IDs
- Shared accounts are prohibited
- Access rights are granted based on least privilege principle
- Access reviews conducted quarterly
- Terminated employees' access revoked within 2 hours

**Procedures:**
1. New user access requests submitted via ServiceNow
2. Manager approval required
3. Security team reviews and approves
4. Access provisioned within 24 hours
5. User acknowledges acceptable use policy

### 1.2 Multi-Factor Authentication (MFA)

**Policy:**
- MFA required for all administrative access
- MFA required for remote access
- MFA required for access to sensitive data
- Biometric or hardware tokens preferred

**Implementation:**
- Duo Security for VPN access
- AWS IAM MFA for cloud resources
- YubiKey for privileged accounts

### 1.3 Password Requirements

**Policy:**
- Minimum 14 characters
- Complexity: uppercase, lowercase, numbers, special characters
- No dictionary words
- Password expiration: 90 days
- Password history: last 12 passwords
- Account lockout: 5 failed attempts

## 2. Data Protection Policy

### 2.1 Data Classification

**Classification Levels:**

| Level | Description | Examples | Controls |
|-------|-------------|----------|----------|
| Public | No harm if disclosed | Marketing materials | Standard |
| Internal | Limited distribution | Internal memos | Access control |
| Confidential | Significant harm if disclosed | Customer data | Encryption + Access control |
| Restricted | Severe harm if disclosed | Financial data, PII | Strong encryption + MFA |

### 2.2 Encryption Standards

**Policy:**
- Data at rest: AES-256 encryption
- Data in transit: TLS 1.2 or higher
- Database encryption: Transparent Data Encryption (TDE)
- Backup encryption: AES-256

**Key Management:**
- AWS KMS for cloud encryption keys
- Hardware Security Modules (HSM) for critical keys
- Key rotation: annually
- Key access logged and monitored

### 2.3 Data Retention

**Policy:**
- Customer data: 7 years
- Financial records: 7 years
- Audit logs: 1 year
- System logs: 90 days
- Backup data: 30 days

## 3. Network Security Policy

### 3.1 Network Segmentation

**Policy:**
- DMZ for public-facing services
- Separate VLANs for each tier (web, app, database)
- Management network isolated
- Guest network segregated

### 3.2 Firewall Management

**Policy:**
- Default deny all traffic
- Explicit allow rules only
- Rule reviews quarterly
- Change management required for all modifications
- Logging enabled for all denied traffic

### 3.3 VPN Access

**Policy:**
- Split tunneling prohibited
- MFA required
- Session timeout: 8 hours
- Idle timeout: 30 minutes
- VPN logs retained for 90 days

## 4. Vulnerability Management Policy

### 4.1 Vulnerability Scanning

**Policy:**
- Automated scans: weekly
- Manual penetration testing: quarterly
- External vulnerability assessment: annually
- New systems scanned before production deployment

### 4.2 Patch Management

**Policy:**
- Critical patches: within 7 days
- High severity patches: within 30 days
- Medium severity patches: within 60 days
- Low severity patches: within 90 days
- Emergency patches: within 24 hours

**Procedures:**
1. Patch assessment and testing
2. Change management approval
3. Deployment to non-production
4. Validation and testing
5. Production deployment
6. Verification and documentation

## 5. Incident Response Policy

### 5.1 Incident Classification

**Severity Levels:**

| Level | Description | Response Time | Escalation |
|-------|-------------|---------------|------------|
| P1 - Critical | System down, data breach | 15 minutes | CISO, CTO |
| P2 - High | Significant impact | 1 hour | Security Manager |
| P3 - Medium | Limited impact | 4 hours | Security Team |
| P4 - Low | Minimal impact | 24 hours | Security Team |

### 5.2 Incident Response Process

**Steps:**
1. **Detection and Analysis**
   - Identify and validate incident
   - Classify severity
   - Assemble response team

2. **Containment**
   - Isolate affected systems
   - Preserve evidence
   - Implement temporary fixes

3. **Eradication**
   - Remove threat
   - Patch vulnerabilities
   - Verify system integrity

4. **Recovery**
   - Restore systems
   - Validate functionality
   - Monitor for recurrence

5. **Post-Incident**
   - Document lessons learned
   - Update procedures
   - Conduct training

## 6. Backup and Recovery Policy

### 6.1 Backup Requirements

**Policy:**
- Full backups: weekly
- Incremental backups: daily
- Transaction log backups: hourly
- Backup retention: 30 days
- Off-site backup storage required

### 6.2 Recovery Objectives

**Targets:**
- Recovery Time Objective (RTO): 4 hours
- Recovery Point Objective (RPO): 1 hour
- Backup testing: monthly
- DR drill: quarterly

## 7. Security Awareness and Training

### 7.1 Training Requirements

**Policy:**
- Security awareness training: annually for all employees
- Role-based training: upon hire and annually
- Phishing simulations: quarterly
- Incident response training: semi-annually for IT staff

### 7.2 Training Topics

- Password security
- Phishing and social engineering
- Data protection
- Incident reporting
- Acceptable use
- Mobile device security

## 8. Third-Party Security

### 8.1 Vendor Risk Assessment

**Policy:**
- Security assessment required before engagement
- Annual security reviews for critical vendors
- Vendor access logged and monitored
- Vendor contracts include security requirements

### 8.2 Vendor Access

**Policy:**
- Least privilege access
- MFA required
- Time-limited access
- Activity monitoring
- Access review quarterly

## 9. Physical Security

### 9.1 Data Center Access

**Policy:**
- Badge access required
- Visitor escort required
- Access logs reviewed monthly
- Security cameras 24/7
- Environmental monitoring

### 9.2 Equipment Security

**Policy:**
- Asset tagging and inventory
- Secure disposal of equipment
- Encryption on all mobile devices
- Screen lock after 5 minutes idle

## 10. Compliance and Audit

### 10.1 Compliance Monitoring

**Policy:**
- Continuous compliance monitoring
- Quarterly compliance reviews
- Annual external audits
- Compliance dashboard maintained

### 10.2 Audit Logging

**Policy:**
- All administrative actions logged
- Authentication events logged
- Log retention: 1 year
- Log review: weekly
- SIEM monitoring 24/7

## 11. Policy Enforcement

### 11.1 Violations

**Consequences:**
- First violation: Written warning
- Second violation: Suspension
- Third violation: Termination
- Criminal activity: Law enforcement notification

### 11.2 Exceptions

**Process:**
- Written exception request required
- Risk assessment conducted
- CISO approval required
- Compensating controls implemented
- Exception review: quarterly

## 12. Policy Review and Updates

**Schedule:**
- Annual policy review
- Updates as needed for regulatory changes
- Version control maintained
- All changes communicated to staff

## Approval

**Policy Owner:** Jane Smith, CISO  
**Approved By:** Sarah Johnson, CEO  
**Approval Date:** March 20, 2024  
**Next Review Date:** March 20, 2025

---

*This document is confidential and proprietary. Unauthorized distribution is prohibited.*
"""
    
    with open(filename, 'w') as f:
        f.write(content)
    
    print(f"Created {filename}")

def create_architecture_diagrams():
    """Generate architecture diagrams documentation"""
    filename = f"{BASE_DIR}/docs/architecture-diagrams.md"
    
    content = """# Infrastructure Architecture Diagrams

**Document Version:** 1.5  
**Last Updated:** March 20, 2024  
**Owner:** Infrastructure Team

## 1. Network Topology

### High-Level Network Architecture

```
Internet
    |
    v
[CloudFront CDN]
    |
    v
[AWS WAF]
    |
    v
[Application Load Balancer] (10.0.1.100)
    |
    +-- [Web Tier] (10.0.11.0/24)
    |   |
    |   +-- web-01 (10.0.11.10)
    |   +-- web-02 (10.0.11.20)
    |   +-- web-03 (10.0.11.30)
    |   +-- web-04 (10.0.12.10)
    |   +-- web-05 (10.0.12.20)
    |
    v
[Internal Load Balancer] (10.0.1.101)
    |
    +-- [Application Tier] (10.0.12.0/24)
    |   |
    |   +-- app-01 (10.0.11.40)
    |   +-- app-02 (10.0.11.50)
    |   +-- app-03 (10.0.12.30)
    |   +-- app-04 (10.0.12.40)
    |   +-- app-05 (10.0.13.10)
    |   +-- app-06 (10.0.13.20)
    |
    v
[Database Tier] (10.0.21.0/24)
    |
    +-- db-primary (10.0.21.10) [Master]
    +-- db-replica (10.0.22.10) [Read Replica]
```

### VPC Architecture

```
AWS Region: us-east-1
VPC CIDR: 10.0.0.0/16

Availability Zones:
+-- AZ-1 (us-east-1a)
|   +-- Public Subnet (10.0.1.0/24)
|   |   +-- NAT Gateway
|   |   +-- Bastion Host
|   +-- Private Subnet (10.0.11.0/24)
|   |   +-- Web Servers (web-01, web-02, web-03)
|   |   +-- App Servers (app-01, app-02)
|   +-- Database Subnet (10.0.21.0/24)
|       +-- db-primary
|
+-- AZ-2 (us-east-1b)
|   +-- Public Subnet (10.0.2.0/24)
|   |   +-- NAT Gateway
|   +-- Private Subnet (10.0.12.0/24)
|   |   +-- Web Servers (web-04, web-05)
|   |   +-- App Servers (app-03, app-04)
|   +-- Database Subnet (10.0.22.0/24)
|       +-- db-replica
|
+-- AZ-3 (us-east-1c)
    +-- Public Subnet (10.0.3.0/24)
    |   +-- NAT Gateway
    +-- Private Subnet (10.0.13.0/24)
        +-- App Servers (app-05, app-06)
```

## 2. Data Center Layout

### Dallas Data Center (Primary)

```
Floor Plan:
+------------------------------------------+
|  Data Center - Dallas, TX                |
|                                          |
|  [Rack 1-10: Web Servers]                |
|  [Rack 11-20: Application Servers]       |
|  [Rack 21-25: Database Servers]          |
|  [Rack 26-30: Storage Arrays]            |
|  [Rack 31-35: Network Equipment]         |
|  [Rack 36-40: Backup Systems]            |
|                                          |
|  Power: Dual A/B Feeds                   |
|  Cooling: N+1 CRAC Units                 |
|  Fire Suppression: FM-200                |
+------------------------------------------+

Network Equipment:
- Core Switches: 2x Cisco Nexus 9000
- Distribution Switches: 4x Cisco Catalyst 9300
- Firewalls: 2x Palo Alto PA-5220
- Load Balancers: 2x F5 BIG-IP 4200v
- VPN Concentrators: 2x Cisco ASA 5585-X
```

### London Data Center (Secondary)

```
Floor Plan:
+------------------------------------------+
|  Data Center - London, UK                |
|                                          |
|  [Rack 1-5: Web Servers]                 |
|  [Rack 6-10: Application Servers]        |
|  [Rack 11-15: Database Servers]          |
|  [Rack 16-20: Storage Arrays]            |
|  [Rack 21-25: Network Equipment]         |
|                                          |
|  Power: Dual A/B Feeds                   |
|  Cooling: N+1 CRAC Units                 |
+------------------------------------------+
```

### Singapore Data Center (DR Site)

```
Floor Plan:
+------------------------------------------+
|  Data Center - Singapore                 |
|                                          |
|  [Rack 1-5: Standby Servers]             |
|  [Rack 6-10: Storage Arrays]             |
|  [Rack 11-15: Network Equipment]         |
|                                          |
|  Power: Dual A/B Feeds                   |
|  Cooling: N+1 CRAC Units                 |
+------------------------------------------+
```

## 3. Hybrid Cloud Connectivity

```
On-Premises Data Centers
    |
    +-- Dallas DC (203.0.113.10)
    |   |
    |   +-- [VPN Tunnel 1] ----+
    |   +-- [VPN Tunnel 2] ----+
    |                          |
    +-- London DC (198.51.100.10)
    |   |                      |
    |   +-- [VPN Tunnel 1] ----+
    |   +-- [VPN Tunnel 2] ----+
    |                          |
    +-- Singapore DC (192.0.2.10)
        |                      |
        +-- [VPN Tunnel 1] ----+
        +-- [VPN Tunnel 2] ----+
                               |
                               v
                    [AWS VPN Gateway]
                               |
                               v
                    [AWS VPC] (10.0.0.0/16)
                               |
                               +-- [Transit Gateway]
                               |
                               +-- [Direct Connect] (10Gbps)
```

## 4. Security Architecture

```
Internet
    |
    v
[DDoS Protection - AWS Shield]
    |
    v
[Web Application Firewall - AWS WAF]
    |
    v
[CloudFront CDN]
    |
    v
[Application Load Balancer]
    |
    +-- [Security Group: web-alb-sg]
    |   - Allow: 80, 443 from 0.0.0.0/0
    |
    v
[Web Tier]
    |
    +-- [Security Group: web-sg]
    |   - Allow: 80, 443 from web-alb-sg
    |   - Allow: 22 from bastion-sg
    |
    v
[Application Tier]
    |
    +-- [Security Group: app-sg]
    |   - Allow: 8080 from web-sg
    |   - Allow: 22 from bastion-sg
    |
    v
[Database Tier]
    |
    +-- [Security Group: db-sg]
        - Allow: 5432, 3306 from app-sg
        - Allow: 22 from bastion-sg

[Bastion Host] (10.0.1.10)
    +-- [Security Group: bastion-sg]
        - Allow: 22 from Corporate IPs only
```

## 5. Monitoring Architecture

```
Infrastructure Components
    |
    +-- [CloudWatch Agent] --> [CloudWatch Logs]
    +-- [Prometheus Exporters] --> [Prometheus] (10.0.11.100)
    +-- [Application Metrics] --> [Prometheus]
    |
    v
[Prometheus]
    |
    +-- [Alert Manager]
    |   |
    |   +-- [SNS Topics]
    |   +-- [PagerDuty]
    |   +-- [Email Notifications]
    |
    v
[Grafana] (10.0.11.101)
    |
    +-- [Dashboards]
    +-- [Alerts]
    +-- [Reports]
```

## 6. Backup and DR Architecture

```
Production Systems
    |
    +-- [Databases]
    |   |
    |   +-- [Automated Backups] --> [S3 Backup Bucket]
    |   +-- [Snapshots] --> [EBS Snapshots]
    |   +-- [Replication] --> [DR Site]
    |
    +-- [Application Data]
    |   |
    |   +-- [EFS Backups] --> [AWS Backup]
    |   +-- [S3 Replication] --> [S3 DR Bucket]
    |
    +-- [Configuration]
        |
        +-- [Terraform State] --> [S3 State Bucket]
        +-- [Ansible Playbooks] --> [Git Repository]

Backup Schedule:
- Full Backup: Daily at 02:00 UTC
- Incremental: Every 6 hours
- Retention: 30 days
- DR Site Sync: Real-time replication
```

## 7. Traffic Flow

### User Request Flow

```
1. User Request
   |
   v
2. DNS Resolution (Route53)
   |
   v
3. CloudFront CDN
   |
   +-- Cache Hit? --> Return Cached Content
   |
   +-- Cache Miss
       |
       v
4. AWS WAF (Security Rules)
   |
   v
5. Application Load Balancer
   |
   v
6. Web Tier (NGINX/Apache)
   |
   v
7. Application Tier (Java/Python)
   |
   v
8. Database Tier (PostgreSQL/MySQL)
   |
   v
9. Response Path (Reverse of above)
```

## 8. Deployment Pipeline

```
Developer
    |
    v
[Git Repository]
    |
    v
[CI/CD Pipeline - Jenkins]
    |
    +-- [Build]
    +-- [Test]
    +-- [Security Scan]
    +-- [Container Build]
    |
    v
[Artifact Repository]
    |
    v
[Deployment]
    |
    +-- [Dev Environment]
    +-- [Staging Environment]
    +-- [Production Environment]
        |
        +-- [Blue/Green Deployment]
        +-- [Canary Deployment]
        +-- [Rollback Capability]
```

## 9. Network Segmentation

```
DMZ (Public Subnets)
- Load Balancers
- Bastion Hosts
- NAT Gateways

Web Tier (Private Subnets)
- Web Servers
- Reverse Proxies

Application Tier (Private Subnets)
- Application Servers
- API Servers
- Message Queues

Database Tier (Private Subnets)
- Database Servers
- Cache Servers

Management Network (Isolated)
- Monitoring Systems
- Backup Systems
- Configuration Management
```

## 10. Capacity Planning

### Current Capacity

| Tier | Servers | CPU Cores | Memory (GB) | Storage (TB) |
|------|---------|-----------|-------------|--------------|
| Web | 5 | 40 | 80 | 0.5 |
| Application | 6 | 96 | 192 | 1.2 |
| Database | 2 | 64 | 512 | 10 |
| **Total** | **13** | **200** | **784** | **11.7** |

### Growth Projections

| Quarter | Servers | CPU Cores | Memory (GB) | Storage (TB) |
|---------|---------|-----------|-------------|--------------|
| Q2 2024 | 15 | 240 | 960 | 15 |
| Q3 2024 | 18 | 288 | 1152 | 20 |
| Q4 2024 | 20 | 320 | 1280 | 25 |

---

*This document contains confidential infrastructure information. Distribution is restricted.*
"""
    
    with open(filename, 'w') as f:
        f.write(content)
    
    print(f"Created {filename}")

# Continue with remaining functions...

if __name__ == '__main__':
    print("Generating security, documentation, and incident files...")
    
    # Security files
    create_vulnerability_scan()
    create_compliance_report()
    create_patch_management_log()
    create_security_policies()
    
    # Documentation
    create_architecture_diagrams()
    
    print("\nSecurity and documentation files created!")
    print("Creating remaining documentation and incident files...")

# Made with Bob
