# VPN Configuration Documentation

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
