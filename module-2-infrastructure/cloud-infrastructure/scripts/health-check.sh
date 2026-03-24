#!/bin/bash

# Infrastructure Health Check Script
# Monitors critical services and system resources

set -e

LOG_FILE="/var/log/health-check.log"
ALERT_THRESHOLD_CPU=80
ALERT_THRESHOLD_MEM=85
ALERT_THRESHOLD_DISK=90

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

send_alert() {
    local severity=$1
    local message=$2
    log "$severity: $message"
    aws sns publish \
        --topic-arn "arn:aws:sns:us-east-1:123456789012:infrastructure-alerts" \
        --subject "[$severity] Infrastructure Health Alert" \
        --message "$message" 2>/dev/null || true
}

# Check CPU usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
CPU_USAGE_INT=${CPU_USAGE%.*}
if [ "$CPU_USAGE_INT" -gt "$ALERT_THRESHOLD_CPU" ]; then
    send_alert "WARNING" "CPU usage is ${CPU_USAGE}% (threshold: ${ALERT_THRESHOLD_CPU}%)"
fi

# Check memory usage
MEM_USAGE=$(free | grep Mem | awk '{print ($3/$2) * 100.0}')
MEM_USAGE_INT=${MEM_USAGE%.*}
if [ "$MEM_USAGE_INT" -gt "$ALERT_THRESHOLD_MEM" ]; then
    send_alert "WARNING" "Memory usage is ${MEM_USAGE}% (threshold: ${ALERT_THRESHOLD_MEM}%)"
fi

# Check disk usage
DISK_USAGE=$(df -h / | tail -1 | awk '{print $5}' | sed 's/%//')
if [ "$DISK_USAGE" -gt "$ALERT_THRESHOLD_DISK" ]; then
    send_alert "CRITICAL" "Disk usage is ${DISK_USAGE}% (threshold: ${ALERT_THRESHOLD_DISK}%)"
fi

# Check critical services
SERVICES=("httpd" "postgresql-15" "amazon-cloudwatch-agent")
for service in "${SERVICES[@]}"; do
    if ! systemctl is-active --quiet "$service" 2>/dev/null; then
        send_alert "CRITICAL" "Service $service is not running"
    fi
done

# Check network connectivity
if ! ping -c 1 8.8.8.8 > /dev/null 2>&1; then
    send_alert "CRITICAL" "No internet connectivity"
fi

# Check load average
LOAD_AVG=$(uptime | awk -F'load average:' '{print $2}' | awk '{print $1}' | sed 's/,//')
LOAD_AVG_INT=${LOAD_AVG%.*}
CPU_COUNT=$(nproc)
if [ "$LOAD_AVG_INT" -gt "$((CPU_COUNT * 2))" ]; then
    send_alert "WARNING" "Load average is ${LOAD_AVG} (CPUs: ${CPU_COUNT})"
fi

log "Health check completed - CPU: ${CPU_USAGE}%, MEM: ${MEM_USAGE}%, DISK: ${DISK_USAGE}%"
