#!/usr/bin/env python3
"""
Generate all remaining infrastructure module files
"""

import json
import os
from datetime import datetime, timedelta
import random

BASE_DIR = "module-2-infrastructure"

def create_critical_alerts_log():
    """Generate critical alerts log with 200+ lines"""
    filename = f"{BASE_DIR}/monitoring/alerts/critical-alerts.log"
    
    servers = ['web-01', 'web-02', 'web-03', 'web-04', 'web-05',
               'app-01', 'app-02', 'app-03', 'app-04', 'app-05', 'app-06',
               'db-primary', 'db-replica']
    
    alert_types = [
        ('CPU_HIGH', 'CPU utilization exceeded 90%'),
        ('MEMORY_HIGH', 'Memory utilization exceeded 85%'),
        ('DISK_FULL', 'Disk usage exceeded 90%'),
        ('SERVICE_DOWN', 'Critical service is not responding'),
        ('NETWORK_LATENCY', 'Network latency exceeded threshold'),
        ('DATABASE_SLOW', 'Database query response time > 5s'),
        ('BACKUP_FAILED', 'Automated backup job failed'),
        ('SSL_EXPIRING', 'SSL certificate expires in < 30 days')
    ]
    
    start_date = datetime.now() - timedelta(days=30)
    
    with open(filename, 'w') as f:
        for i in range(250):
            timestamp = start_date + timedelta(hours=random.randint(0, 720))
            server = random.choice(servers)
            alert_type, message = random.choice(alert_types)
            severity = random.choice(['CRITICAL', 'CRITICAL', 'HIGH'])
            
            f.write(f"[{timestamp.strftime('%Y-%m-%d %H:%M:%S')}] [{severity}] [{server}] {alert_type}: {message}\n")
    
    print(f"Created {filename}")

def create_warning_alerts_log():
    """Generate warning alerts log"""
    filename = f"{BASE_DIR}/monitoring/alerts/warning-alerts.log"
    
    servers = ['web-01', 'web-02', 'web-03', 'web-04', 'web-05',
               'app-01', 'app-02', 'app-03', 'app-04', 'app-05', 'app-06',
               'db-primary', 'db-replica']
    
    alert_types = [
        ('CPU_ELEVATED', 'CPU utilization exceeded 80%'),
        ('MEMORY_ELEVATED', 'Memory utilization exceeded 75%'),
        ('DISK_SPACE', 'Disk usage exceeded 80%'),
        ('SLOW_RESPONSE', 'Response time degraded'),
        ('CONNECTION_POOL', 'Database connection pool at 70%'),
        ('LOG_VOLUME', 'Log volume increased significantly'),
        ('CACHE_MISS', 'Cache miss rate elevated')
    ]
    
    start_date = datetime.now() - timedelta(days=30)
    
    with open(filename, 'w') as f:
        for i in range(300):
            timestamp = start_date + timedelta(hours=random.randint(0, 720))
            server = random.choice(servers)
            alert_type, message = random.choice(alert_types)
            
            f.write(f"[{timestamp.strftime('%Y-%m-%d %H:%M:%S')}] [WARNING] [{server}] {alert_type}: {message}\n")
    
    print(f"Created {filename}")

def create_alert_rules():
    """Generate alert rules YAML"""
    filename = f"{BASE_DIR}/monitoring/alerts/alert-rules.yml"
    
    content = """# Alert Rules Configuration for GlobalTech Infrastructure

groups:
  - name: infrastructure_alerts
    interval: 30s
    rules:
      - alert: HighCPUUsage
        expr: cpu_usage_percent > 80
        for: 5m
        labels:
          severity: warning
          component: compute
        annotations:
          summary: "High CPU usage on {{ $labels.instance }}"
          description: "CPU usage is {{ $value }}% on {{ $labels.instance }}"
      
      - alert: CriticalCPUUsage
        expr: cpu_usage_percent > 90
        for: 2m
        labels:
          severity: critical
          component: compute
        annotations:
          summary: "Critical CPU usage on {{ $labels.instance }}"
          description: "CPU usage is {{ $value }}% on {{ $labels.instance }}"
      
      - alert: HighMemoryUsage
        expr: memory_usage_percent > 85
        for: 5m
        labels:
          severity: warning
          component: memory
        annotations:
          summary: "High memory usage on {{ $labels.instance }}"
          description: "Memory usage is {{ $value }}% on {{ $labels.instance }}"
      
      - alert: CriticalMemoryUsage
        expr: memory_usage_percent > 95
        for: 2m
        labels:
          severity: critical
          component: memory
        annotations:
          summary: "Critical memory usage on {{ $labels.instance }}"
          description: "Memory usage is {{ $value }}% on {{ $labels.instance }}"
      
      - alert: DiskSpaceWarning
        expr: disk_usage_percent > 90
        for: 10m
        labels:
          severity: warning
          component: storage
        annotations:
          summary: "Disk space warning on {{ $labels.instance }}"
          description: "Disk usage is {{ $value }}% on {{ $labels.instance }}"
      
      - alert: DiskSpaceCritical
        expr: disk_usage_percent > 95
        for: 5m
        labels:
          severity: critical
          component: storage
        annotations:
          summary: "Critical disk space on {{ $labels.instance }}"
          description: "Disk usage is {{ $value }}% on {{ $labels.instance }}"
      
      - alert: ServiceDown
        expr: up == 0
        for: 1m
        labels:
          severity: critical
          component: availability
        annotations:
          summary: "Service down: {{ $labels.job }}"
          description: "{{ $labels.job }} on {{ $labels.instance }} is down"
      
      - alert: HighNetworkLatency
        expr: network_latency_ms > 100
        for: 5m
        labels:
          severity: warning
          component: network
        annotations:
          summary: "High network latency on {{ $labels.instance }}"
          description: "Network latency is {{ $value }}ms on {{ $labels.instance }}"
      
      - alert: DatabaseSlowQueries
        expr: database_query_duration_seconds > 5
        for: 2m
        labels:
          severity: warning
          component: database
        annotations:
          summary: "Slow database queries detected"
          description: "Query duration is {{ $value }}s on {{ $labels.instance }}"
      
      - alert: BackupFailure
        expr: backup_last_success_timestamp < (time() - 86400)
        for: 1m
        labels:
          severity: critical
          component: backup
        annotations:
          summary: "Backup failure detected"
          description: "Last successful backup was more than 24 hours ago"
      
      - alert: SSLCertificateExpiring
        expr: ssl_certificate_expiry_days < 30
        for: 1h
        labels:
          severity: warning
          component: security
        annotations:
          summary: "SSL certificate expiring soon"
          description: "SSL certificate expires in {{ $value }} days"
      
      - alert: LoadBalancerUnhealthy
        expr: lb_healthy_targets / lb_total_targets < 0.5
        for: 2m
        labels:
          severity: critical
          component: load_balancer
        annotations:
          summary: "Load balancer has unhealthy targets"
          description: "Only {{ $value }}% of targets are healthy"
"""
    
    with open(filename, 'w') as f:
        f.write(content)
    
    print(f"Created {filename}")

def create_grafana_dashboard():
    """Generate Grafana dashboard JSON"""
    filename = f"{BASE_DIR}/monitoring/dashboards/infrastructure-overview.json"
    
    dashboard = {
        "dashboard": {
            "title": "Infrastructure Overview",
            "tags": ["infrastructure", "monitoring"],
            "timezone": "browser",
            "panels": [
                {
                    "id": 1,
                    "title": "CPU Usage by Server",
                    "type": "graph",
                    "gridPos": {"x": 0, "y": 0, "w": 12, "h": 8},
                    "targets": [{
                        "expr": "cpu_usage_percent",
                        "legendFormat": "{{instance}}"
                    }]
                },
                {
                    "id": 2,
                    "title": "Memory Usage by Server",
                    "type": "graph",
                    "gridPos": {"x": 12, "y": 0, "w": 12, "h": 8},
                    "targets": [{
                        "expr": "memory_usage_percent",
                        "legendFormat": "{{instance}}"
                    }]
                },
                {
                    "id": 3,
                    "title": "Disk Usage",
                    "type": "graph",
                    "gridPos": {"x": 0, "y": 8, "w": 12, "h": 8},
                    "targets": [{
                        "expr": "disk_usage_percent",
                        "legendFormat": "{{instance}}"
                    }]
                },
                {
                    "id": 4,
                    "title": "Network Traffic",
                    "type": "graph",
                    "gridPos": {"x": 12, "y": 8, "w": 12, "h": 8},
                    "targets": [{
                        "expr": "network_bytes_total",
                        "legendFormat": "{{instance}}"
                    }]
                },
                {
                    "id": 5,
                    "title": "Active Alerts",
                    "type": "stat",
                    "gridPos": {"x": 0, "y": 16, "w": 6, "h": 4},
                    "targets": [{
                        "expr": "count(ALERTS{alertstate='firing'})"
                    }]
                },
                {
                    "id": 6,
                    "title": "Service Uptime",
                    "type": "stat",
                    "gridPos": {"x": 6, "y": 16, "w": 6, "h": 4},
                    "targets": [{
                        "expr": "avg(up) * 100"
                    }]
                }
            ],
            "refresh": "30s",
            "time": {"from": "now-6h", "to": "now"}
        }
    }
    
    with open(filename, 'w') as f:
        json.dump(dashboard, f, indent=2)
    
    print(f"Created {filename}")

def create_firewall_rules():
    """Generate firewall rules"""
    filename = f"{BASE_DIR}/network/firewall-rules.txt"
    
    content = """# GlobalTech Enterprise Firewall Rules
# Last Updated: 2024-03-20
# Managed by: Infrastructure Team

# ============================================
# INBOUND RULES
# ============================================

# Rule 1: Allow HTTP from Internet to Web Tier
ALLOW TCP 0.0.0.0/0 -> 10.0.11.0/24 PORT 80 PRIORITY 100

# Rule 2: Allow HTTPS from Internet to Web Tier
ALLOW TCP 0.0.0.0/0 -> 10.0.11.0/24 PORT 443 PRIORITY 100

# Rule 3: Allow SSH from Corporate Network
ALLOW TCP 203.0.113.0/24 -> 10.0.0.0/16 PORT 22 PRIORITY 200

# Rule 4: Allow SSH from Bastion
ALLOW TCP 10.0.1.10/32 -> 10.0.0.0/16 PORT 22 PRIORITY 150

# Rule 5: Allow Application Traffic from Web to App Tier
ALLOW TCP 10.0.11.0/24 -> 10.0.12.0/24 PORT 8080 PRIORITY 300

# Rule 6: Allow Database Traffic from App to DB Tier
ALLOW TCP 10.0.12.0/24 -> 10.0.21.0/24 PORT 5432 PRIORITY 300

# Rule 7: Allow MySQL from App to DB Tier
ALLOW TCP 10.0.12.0/24 -> 10.0.21.0/24 PORT 3306 PRIORITY 300

# Rule 8: Allow Monitoring from Prometheus
ALLOW TCP 10.0.11.100/32 -> 10.0.0.0/16 PORT 9100 PRIORITY 400

# Rule 9: Allow VPN from Dallas DC
ALLOW UDP 203.0.113.10/32 -> 10.0.0.0/16 PORT 500,4500 PRIORITY 500

# Rule 10: Allow VPN from London DC
ALLOW UDP 198.51.100.10/32 -> 10.0.0.0/16 PORT 500,4500 PRIORITY 500

# Rule 11: Allow VPN from Singapore DC
ALLOW UDP 192.0.2.10/32 -> 10.0.0.0/16 PORT 500,4500 PRIORITY 500

# Rule 12: Allow NTP
ALLOW UDP 0.0.0.0/0 -> 10.0.0.0/16 PORT 123 PRIORITY 600

# Rule 13: Allow DNS
ALLOW UDP 0.0.0.0/0 -> 10.0.0.0/16 PORT 53 PRIORITY 600

# Rule 14: Allow ICMP (Ping)
ALLOW ICMP 10.0.0.0/16 -> 10.0.0.0/16 PRIORITY 700

# Rule 15: Allow Load Balancer Health Checks
ALLOW TCP 10.0.1.0/24 -> 10.0.11.0/24 PORT 80,443 PRIORITY 250

# ============================================
# OUTBOUND RULES
# ============================================

# Rule 20: Allow HTTP/HTTPS to Internet
ALLOW TCP 10.0.0.0/16 -> 0.0.0.0/0 PORT 80,443 PRIORITY 100

# Rule 21: Allow DNS to Internet
ALLOW UDP 10.0.0.0/16 -> 0.0.0.0/0 PORT 53 PRIORITY 100

# Rule 22: Allow NTP to Internet
ALLOW UDP 10.0.0.0/16 -> 0.0.0.0/0 PORT 123 PRIORITY 100

# Rule 23: Allow Email (SMTP)
ALLOW TCP 10.0.0.0/16 -> 0.0.0.0/0 PORT 25,587 PRIORITY 200

# Rule 24: Allow S3 Access
ALLOW TCP 10.0.0.0/16 -> 52.216.0.0/15 PORT 443 PRIORITY 300

# ============================================
# SECURITY RULES
# ============================================

# Rule 30: Block SSH from Internet (SECURITY)
DENY TCP 0.0.0.0/0 -> 10.0.0.0/16 PORT 22 PRIORITY 50

# Rule 31: Block RDP from Internet (SECURITY)
DENY TCP 0.0.0.0/0 -> 10.0.0.0/16 PORT 3389 PRIORITY 50

# Rule 32: Block Telnet (SECURITY)
DENY TCP 0.0.0.0/0 -> 10.0.0.0/16 PORT 23 PRIORITY 50

# Rule 33: Block FTP (SECURITY)
DENY TCP 0.0.0.0/0 -> 10.0.0.0/16 PORT 20,21 PRIORITY 50

# Rule 34: Block SMB (SECURITY)
DENY TCP 0.0.0.0/0 -> 10.0.0.0/16 PORT 445,139 PRIORITY 50

# Rule 35: Block Database Ports from Internet (SECURITY)
DENY TCP 0.0.0.0/0 -> 10.0.0.0/16 PORT 3306,5432,1433,27017 PRIORITY 50

# ============================================
# INTER-TIER RULES
# ============================================

# Rule 40: Allow Web to App Communication
ALLOW TCP 10.0.11.0/24 -> 10.0.12.0/24 PORT 8080,8443 PRIORITY 300

# Rule 41: Allow App to Database Communication
ALLOW TCP 10.0.12.0/24 -> 10.0.21.0/24 PORT 5432,3306 PRIORITY 300

# Rule 42: Allow App to Cache (Redis)
ALLOW TCP 10.0.12.0/24 -> 10.0.13.0/24 PORT 6379 PRIORITY 300

# Rule 43: Allow App to Message Queue (RabbitMQ)
ALLOW TCP 10.0.12.0/24 -> 10.0.13.0/24 PORT 5672 PRIORITY 300

# Rule 44: Deny Direct Web to Database (SECURITY)
DENY TCP 10.0.11.0/24 -> 10.0.21.0/24 PORT 5432,3306 PRIORITY 250

# ============================================
# LOGGING AND MONITORING
# ============================================

# Rule 50: Allow Syslog
ALLOW UDP 10.0.0.0/16 -> 10.0.11.101/32 PORT 514 PRIORITY 400

# Rule 51: Allow SNMP Monitoring
ALLOW UDP 10.0.11.100/32 -> 10.0.0.0/16 PORT 161 PRIORITY 400

# Rule 52: Allow CloudWatch Agent
ALLOW TCP 10.0.0.0/16 -> 0.0.0.0/0 PORT 443 PRIORITY 400

# ============================================
# DEFAULT DENY
# ============================================

# Rule 999: Default Deny All
DENY ALL 0.0.0.0/0 -> 0.0.0.0/0 PRIORITY 999

# End of Firewall Rules
"""
    
    with open(filename, 'w') as f:
        f.write(content)
    
    print(f"Created {filename}")

def create_load_balancer_config():
    """Generate load balancer configuration"""
    filename = f"{BASE_DIR}/network/load-balancer-config.conf"
    
    content = """# F5 BIG-IP Load Balancer Configuration
# GlobalTech Enterprise Production Environment
# Configuration Version: 2.1
# Last Modified: 2024-03-20

# ============================================
# GLOBAL SETTINGS
# ============================================

ltm global-settings {
    general {
        hostname lb-prod-01.globaltech.internal
        description "Production Load Balancer - Primary"
    }
    load-balancing {
        mode least-connections-member
        priority-group-activation disabled
    }
}

# ============================================
# WEB TIER POOL
# ============================================

ltm pool web_tier_pool {
    description "Web Tier Server Pool"
    load-balancing-mode least-connections-member
    min-active-members 2
    monitor http_monitor
    
    members {
        web-01.globaltech.internal:80 {
            address 10.0.11.10
            priority-group 10
            state up
        }
        web-02.globaltech.internal:80 {
            address 10.0.11.20
            priority-group 10
            state up
        }
        web-03.globaltech.internal:80 {
            address 10.0.11.30
            priority-group 10
            state up
        }
        web-04.globaltech.internal:80 {
            address 10.0.12.10
            priority-group 10
            state up
        }
        web-05.globaltech.internal:80 {
            address 10.0.12.20
            priority-group 10
            state up
        }
    }
}

# ============================================
# APPLICATION TIER POOL
# ============================================

ltm pool app_tier_pool {
    description "Application Tier Server Pool"
    load-balancing-mode least-connections-member
    min-active-members 3
    monitor tcp_monitor
    
    members {
        app-01.globaltech.internal:8080 {
            address 10.0.11.40
            priority-group 10
            state up
        }
        app-02.globaltech.internal:8080 {
            address 10.0.11.50
            priority-group 10
            state up
        }
        app-03.globaltech.internal:8080 {
            address 10.0.12.30
            priority-group 10
            state up
        }
        app-04.globaltech.internal:8080 {
            address 10.0.12.40
            priority-group 10
            state up
        }
        app-05.globaltech.internal:8080 {
            address 10.0.13.10
            priority-group 10
            state up
        }
        app-06.globaltech.internal:8080 {
            address 10.0.13.20
            priority-group 10
            state up
        }
    }
}

# ============================================
# HEALTH MONITORS
# ============================================

ltm monitor http http_monitor {
    defaults-from http
    description "HTTP Health Check"
    destination *:80
    interval 10
    timeout 31
    send "GET /health HTTP/1.1\\r\\nHost: localhost\\r\\n\\r\\n"
    recv "200 OK"
}

ltm monitor tcp tcp_monitor {
    defaults-from tcp
    description "TCP Health Check"
    destination *:8080
    interval 10
    timeout 31
}

ltm monitor https https_monitor {
    defaults-from https
    description "HTTPS Health Check"
    destination *:443
    interval 10
    timeout 31
    send "GET /health HTTP/1.1\\r\\nHost: localhost\\r\\n\\r\\n"
    recv "200 OK"
}

# ============================================
# VIRTUAL SERVERS
# ============================================

ltm virtual web_vip_http {
    description "Web Tier HTTP Virtual Server"
    destination 10.0.1.100:80
    ip-protocol tcp
    mask 255.255.255.255
    pool web_tier_pool
    profiles {
        http { }
        tcp { }
    }
    source 0.0.0.0/0
    source-address-translation {
        type automap
    }
    translate-address enabled
    translate-port enabled
}

ltm virtual web_vip_https {
    description "Web Tier HTTPS Virtual Server"
    destination 10.0.1.100:443
    ip-protocol tcp
    mask 255.255.255.255
    pool web_tier_pool
    profiles {
        http { }
        tcp { }
        clientssl {
            context clientside
        }
    }
    source 0.0.0.0/0
    source-address-translation {
        type automap
    }
    translate-address enabled
    translate-port enabled
}

ltm virtual app_vip {
    description "Application Tier Virtual Server"
    destination 10.0.1.101:8080
    ip-protocol tcp
    mask 255.255.255.255
    pool app_tier_pool
    profiles {
        http { }
        tcp { }
    }
    source 10.0.11.0/24
    source-address-translation {
        type automap
    }
    translate-address enabled
    translate-port enabled
}

# ============================================
# PERSISTENCE PROFILES
# ============================================

ltm persistence cookie web_cookie_persistence {
    cookie-name "SERVERID"
    defaults-from cookie
    expiration 0:0:0
    method insert
}

ltm persistence source-addr app_source_persistence {
    defaults-from source_addr
    timeout 300
}

# ============================================
# SSL PROFILES
# ============================================

ltm profile client-ssl clientssl_profile {
    cert globaltech.crt
    key globaltech.key
    chain globaltech-chain.crt
    ciphers DEFAULT:!SSLv3:!TLSv1
    options { dont-insert-empty-fragments no-tlsv1 }
}

# ============================================
# iRULES
# ============================================

ltm rule redirect_to_https {
    when HTTP_REQUEST {
        HTTP::redirect https://[HTTP::host][HTTP::uri]
    }
}

ltm rule maintenance_page {
    when HTTP_REQUEST {
        if { [active_members web_tier_pool] < 1 } {
            HTTP::respond 503 content {
                <html>
                <head><title>Maintenance</title></head>
                <body><h1>Site Under Maintenance</h1></body>
                </html>
            }
        }
    }
}

# End of Configuration
"""
    
    with open(filename, 'w') as f:
        f.write(content)
    
    print(f"Created {filename}")

def create_dns_records():
    """Generate DNS zone file"""
    filename = f"{BASE_DIR}/network/dns-records.zone"
    
    content = """$ORIGIN globaltech.com.
$TTL 3600

; SOA Record
@       IN      SOA     ns1.globaltech.com. admin.globaltech.com. (
                        2024032001  ; Serial
                        7200        ; Refresh
                        3600        ; Retry
                        1209600     ; Expire
                        3600 )      ; Minimum TTL

; Name Servers
@       IN      NS      ns1.globaltech.com.
@       IN      NS      ns2.globaltech.com.

; A Records - Name Servers
ns1     IN      A       203.0.113.10
ns2     IN      A       198.51.100.10

; A Records - Web Tier
www     IN      A       10.0.1.100
web-01  IN      A       10.0.11.10
web-02  IN      A       10.0.11.20
web-03  IN      A       10.0.11.30
web-04  IN      A       10.0.12.10
web-05  IN      A       10.0.12.20

; A Records - Application Tier
app-01  IN      A       10.0.11.40
app-02  IN      A       10.0.11.50
app-03  IN      A       10.0.12.30
app-04  IN      A       10.0.12.40
app-05  IN      A       10.0.13.10
app-06  IN      A       10.0.13.20

; A Records - Database Tier
db-primary      IN      A       10.0.21.10
db-replica      IN      A       10.0.22.10
db-master       IN      CNAME   db-primary
db-slave        IN      CNAME   db-replica

; A Records - Infrastructure
bastion         IN      A       10.0.1.10
prometheus      IN      A       10.0.11.100
grafana         IN      A       10.0.11.101
lb-prod-01      IN      A       10.0.1.100
lb-prod-02      IN      A       10.0.1.101

; CNAME Records
api             IN      CNAME   www
portal          IN      CNAME   www
admin           IN      CNAME   www
monitoring      IN      CNAME   grafana
metrics         IN      CNAME   prometheus

; MX Records
@       IN      MX      10      mail1.globaltech.com.
@       IN      MX      20      mail2.globaltech.com.

mail1   IN      A       203.0.113.50
mail2   IN      A       198.51.100.50

; TXT Records
@       IN      TXT     "v=spf1 mx a:mail1.globaltech.com a:mail2.globaltech.com -all"
_dmarc  IN      TXT     "v=DMARC1; p=quarantine; rua=mailto:dmarc@globaltech.com"

; SRV Records
_http._tcp      IN      SRV     0 5 80 www.globaltech.com.
_https._tcp     IN      SRV     0 5 443 www.globaltech.com.

; PTR Records (Reverse DNS)
; These would be in separate reverse zone files

; End of Zone File
"""
    
    with open(filename, 'w') as f:
        f.write(content)
    
    print(f"Created {filename}")

def create_vpn_configuration():
    """Generate VPN configuration documentation"""
    filename = f"{BASE_DIR}/network/vpn-configuration.md"
    
    content = """# VPN Configuration Documentation

## Overview

GlobalTech Enterprise operates site-to-site VPN connections between AWS and three on-premises data centers for secure hybrid cloud connectivity.

## VPN Tunnels

### Dallas Data Center (Primary)
- **Customer Gateway IP:** 203.0.113.10
- **BGP ASN:** 65001
- **Tunnel 1 IP:** 169.254.10.1/30
- **Tunnel 2 IP:** 169.254.10.5/30
- **Pre-shared Key:** [Stored in AWS Secrets Manager]
- **Status:** Active
- **Bandwidth:** 1 Gbps
- **Latency:** ~15ms

### London Data Center (Secondary)
- **Customer Gateway IP:** 198.51.100.10
- **BGP ASN:** 65002
- **Tunnel 1 IP:** 169.254.20.1/30
- **Tunnel 2 IP:** 169.254.20.5/30
- **Pre-shared Key:** [Stored in AWS Secrets Manager]
- **Status:** Active
- **Bandwidth:** 500 Mbps
- **Latency:** ~85ms

### Singapore Data Center (DR)
- **Customer Gateway IP:** 192.0.2.10
- **BGP ASN:** 65003
- **Tunnel 1 IP:** 169.254.30.1/30
- **Tunnel 2 IP:** 169.254.30.5/30
- **Pre-shared Key:** [Stored in AWS Secrets Manager]
- **Status:** Standby
- **Bandwidth:** 500 Mbps
- **Latency:** ~180ms

## VPN Configuration

### IKE Phase 1
- **Encryption:** AES-256
- **Integrity:** SHA-256
- **DH Group:** 14 (2048-bit)
- **Lifetime:** 28800 seconds (8 hours)

### IKE Phase 2 (IPsec)
- **Encryption:** AES-256
- **Integrity:** SHA-256
- **PFS Group:** 14 (2048-bit)
- **Lifetime:** 3600 seconds (1 hour)

### BGP Configuration
- **AWS BGP ASN:** 64512
- **Hold Time:** 30 seconds
- **Keepalive:** 10 seconds

## Routing

### Advertised Routes from AWS
- 10.0.0.0/16 (VPC CIDR)
- 172.31.0.0/16 (Additional VPC)

### Advertised Routes from On-Premises
- **Dallas:** 192.168.1.0/24, 192.168.2.0/24
- **London:** 192.168.10.0/24, 192.168.11.0/24
- **Singapore:** 192.168.20.0/24, 192.168.21.0/24

## Monitoring

### Health Checks
- **Interval:** 10 seconds
- **Timeout:** 30 seconds
- **Failure Threshold:** 3 consecutive failures

### Metrics Monitored
- Tunnel status (up/down)
- Bytes in/out
- Packets in/out
- Tunnel state change events

### Alerts
- VPN tunnel down (Critical)
- High packet loss >1% (Warning)
- Latency >200ms (Warning)
- BGP session down (Critical)

## Troubleshooting

### Common Issues

#### Tunnel Flapping
**Symptoms:** VPN tunnel repeatedly goes up and down
**Causes:**
- Network instability
- Firewall blocking UDP 500/4500
- MTU issues

**Resolution:**
1. Check firewall rules
2. Verify MTU settings (recommended: 1400)
3. Review IKE logs

#### High Latency
**Symptoms:** Increased response times across VPN
**Causes:**
- Network congestion
- Routing issues
- ISP problems

**Resolution:**
1. Check bandwidth utilization
2. Verify routing tables
3. Contact ISP if needed

#### BGP Session Down
**Symptoms:** Routes not being advertised
**Causes:**
- Tunnel down
- BGP configuration mismatch
- Firewall blocking TCP 179

**Resolution:**
1. Verify tunnel status
2. Check BGP configuration
3. Review firewall rules

## Maintenance Windows

- **Primary Window:** Sunday 02:00-04:00 UTC
- **Emergency Window:** As needed with 2-hour notice

## Security

### Access Control
- VPN configuration changes require approval from:
  - Network Team Lead
  - Security Team
  - Infrastructure Manager

### Audit
- All VPN configuration changes are logged
- Monthly security reviews
- Quarterly penetration testing

## Disaster Recovery

### Failover Procedure
1. Verify primary tunnel is down
2. Activate secondary tunnel
3. Update routing tables
4. Verify connectivity
5. Notify stakeholders

### Recovery Time Objective (RTO)
- **Target:** 15 minutes
- **Maximum:** 30 minutes

### Recovery Point Objective (RPO)
- **Target:** 0 minutes (real-time replication)

## Contact Information

- **Network Team:** network-team@globaltech.com
- **24/7 NOC:** +1-555-0100
- **Emergency Escalation:** infrastructure-oncall@globaltech.com

## Change Log

| Date | Change | Author |
|------|--------|--------|
| 2024-03-20 | Initial documentation | Network Team |
| 2024-03-15 | Added Singapore DC | Network Team |
| 2024-02-01 | Updated encryption to AES-256 | Security Team |
"""
    
    with open(filename, 'w') as f:
        f.write(content)
    
    print(f"Created {filename}")

if __name__ == '__main__':
    print("Generating remaining infrastructure files...")
    
    # Monitoring alerts
    create_critical_alerts_log()
    create_warning_alerts_log()
    create_alert_rules()
    
    # Monitoring dashboards
    create_grafana_dashboard()
    
    # Network configuration
    create_firewall_rules()
    create_load_balancer_config()
    create_dns_records()
    create_vpn_configuration()
    
    print("\nAll monitoring and network files created successfully!")
    print("Remaining: Security files, Documentation, and Incident reports")

# Made with Bob
