# Infrastructure Architecture Diagrams

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
