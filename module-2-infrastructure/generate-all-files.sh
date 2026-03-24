#!/bin/bash

# Script to generate all remaining infrastructure module files
set -e

BASE_DIR="module-2-infrastructure"

echo "Generating remaining infrastructure module files..."

# Create database-config.yml
cat > "$BASE_DIR/cloud-infrastructure/ansible/playbooks/database-config.yml" << 'EOF'
---
- name: Configure Database Servers
  hosts: database_servers
  become: yes
  vars:
    postgres_version: "15"
    postgres_data_dir: /var/lib/pgsql/15/data
    postgres_port: 5432
    max_connections: 200
    shared_buffers: "4GB"
    effective_cache_size: "12GB"
    
  tasks:
    - name: Install PostgreSQL repository
      yum:
        name: https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
        state: present
      tags: [postgres, repo]
    
    - name: Install PostgreSQL
      yum:
        name:
          - postgresql{{ postgres_version }}
          - postgresql{{ postgres_version }}-server
          - postgresql{{ postgres_version }}-contrib
          - python3-psycopg2
        state: present
      tags: [postgres, packages]
    
    - name: Initialize PostgreSQL database
      command: /usr/pgsql-{{ postgres_version }}/bin/postgresql-{{ postgres_version }}-setup initdb
      args:
        creates: "{{ postgres_data_dir }}/PG_VERSION"
      tags: [postgres, init]
    
    - name: Configure PostgreSQL
      template:
        src: ../templates/postgresql.conf.j2
        dest: "{{ postgres_data_dir }}/postgresql.conf"
        owner: postgres
        group: postgres
        mode: '0600'
      notify: restart postgresql
      tags: [postgres, config]
    
    - name: Configure pg_hba.conf
      template:
        src: ../templates/pg_hba.conf.j2
        dest: "{{ postgres_data_dir }}/pg_hba.conf"
        owner: postgres
        group: postgres
        mode: '0600'
      notify: restart postgresql
      tags: [postgres, config]
    
    - name: Enable and start PostgreSQL
      systemd:
        name: postgresql-{{ postgres_version }}
        enabled: yes
        state: started
      tags: [postgres, services]
    
    - name: Create application database
      postgresql_db:
        name: globaltech
        encoding: UTF-8
        lc_collate: en_US.UTF-8
        lc_ctype: en_US.UTF-8
        template: template0
      become_user: postgres
      tags: [postgres, database]
    
    - name: Create application user
      postgresql_user:
        name: app_user
        password: "{{ db_password }}"
        db: globaltech
        priv: ALL
      become_user: postgres
      tags: [postgres, users]
    
    - name: Configure backup script
      template:
        src: ../templates/pg_backup.sh.j2
        dest: /usr/local/bin/pg_backup.sh
        owner: postgres
        group: postgres
        mode: '0750'
      tags: [postgres, backup]
    
    - name: Schedule database backups
      cron:
        name: "PostgreSQL backup"
        minute: "0"
        hour: "2"
        job: "/usr/local/bin/pg_backup.sh"
        user: postgres
      tags: [postgres, backup, cron]
  
  handlers:
    - name: restart postgresql
      systemd:
        name: postgresql-{{ postgres_version }}
        state: restarted
EOF

# Create security-hardening.yml
cat > "$BASE_DIR/cloud-infrastructure/ansible/playbooks/security-hardening.yml" << 'EOF'
---
- name: Security Hardening
  hosts: all
  become: yes
  
  tasks:
    - name: Update all packages
      yum:
        name: '*'
        state: latest
        security: yes
      tags: [security, updates]
    
    - name: Install security tools
      yum:
        name:
          - aide
          - fail2ban
          - rkhunter
          - lynis
          - audit
        state: present
      tags: [security, packages]
    
    - name: Configure SSH hardening
      lineinfile:
        path: /etc/ssh/sshd_config
        regexp: "{{ item.regexp }}"
        line: "{{ item.line }}"
        state: present
      loop:
        - { regexp: '^PermitRootLogin', line: 'PermitRootLogin no' }
        - { regexp: '^PasswordAuthentication', line: 'PasswordAuthentication no' }
        - { regexp: '^X11Forwarding', line: 'X11Forwarding no' }
        - { regexp: '^MaxAuthTries', line: 'MaxAuthTries 3' }
        - { regexp: '^ClientAliveInterval', line: 'ClientAliveInterval 300' }
        - { regexp: '^ClientAliveCountMax', line: 'ClientAliveCountMax 2' }
      notify: restart sshd
      tags: [security, ssh]
    
    - name: Configure firewall default policies
      firewalld:
        state: enabled
        permanent: yes
      tags: [security, firewall]
    
    - name: Disable unnecessary services
      systemd:
        name: "{{ item }}"
        enabled: no
        state: stopped
      loop:
        - postfix
        - cups
      ignore_errors: yes
      tags: [security, services]
    
    - name: Set file permissions on sensitive files
      file:
        path: "{{ item }}"
        mode: '0600'
        owner: root
        group: root
      loop:
        - /etc/ssh/sshd_config
        - /etc/shadow
        - /etc/gshadow
      tags: [security, permissions]
    
    - name: Configure auditd rules
      copy:
        content: |
          -w /etc/passwd -p wa -k passwd_changes
          -w /etc/group -p wa -k group_changes
          -w /etc/shadow -p wa -k shadow_changes
          -w /etc/sudoers -p wa -k sudoers_changes
          -w /var/log/lastlog -p wa -k logins
          -w /var/run/faillock/ -p wa -k logins
        dest: /etc/audit/rules.d/hardening.rules
        owner: root
        group: root
        mode: '0640'
      notify: restart auditd
      tags: [security, audit]
    
    - name: Initialize AIDE database
      command: aide --init
      args:
        creates: /var/lib/aide/aide.db.new.gz
      tags: [security, aide]
    
    - name: Configure fail2ban
      template:
        src: ../templates/jail.local.j2
        dest: /etc/fail2ban/jail.local
        owner: root
        group: root
        mode: '0644'
      notify: restart fail2ban
      tags: [security, fail2ban]
    
    - name: Enable and start security services
      systemd:
        name: "{{ item }}"
        enabled: yes
        state: started
      loop:
        - auditd
        - fail2ban
      tags: [security, services]
  
  handlers:
    - name: restart sshd
      systemd:
        name: sshd
        state: restarted
    
    - name: restart auditd
      command: service auditd restart
    
    - name: restart fail2ban
      systemd:
        name: fail2ban
        state: restarted
EOF

# Create production.ini
cat > "$BASE_DIR/cloud-infrastructure/ansible/inventory/production.ini" << 'EOF'
[web_servers]
web-01.globaltech.internal ansible_host=10.0.11.10
web-02.globaltech.internal ansible_host=10.0.11.20
web-03.globaltech.internal ansible_host=10.0.11.30
web-04.globaltech.internal ansible_host=10.0.12.10
web-05.globaltech.internal ansible_host=10.0.12.20

[app_servers]
app-01.globaltech.internal ansible_host=10.0.11.40
app-02.globaltech.internal ansible_host=10.0.11.50
app-03.globaltech.internal ansible_host=10.0.12.30
app-04.globaltech.internal ansible_host=10.0.12.40
app-05.globaltech.internal ansible_host=10.0.13.10
app-06.globaltech.internal ansible_host=10.0.13.20

[database_servers]
db-primary.globaltech.internal ansible_host=10.0.21.10
db-replica.globaltech.internal ansible_host=10.0.22.10

[bastion]
bastion.globaltech.internal ansible_host=10.0.1.10

[monitoring]
prometheus.globaltech.internal ansible_host=10.0.11.100
grafana.globaltech.internal ansible_host=10.0.11.101

[us_east:children]
web_servers
app_servers
database_servers

[production:children]
us_east
bastion
monitoring

[production:vars]
ansible_user=ec2-user
ansible_ssh_private_key_file=~/.ssh/globaltech-prod.pem
ansible_python_interpreter=/usr/bin/python3
environment=production
EOF

# Create backup-automation.sh
cat > "$BASE_DIR/cloud-infrastructure/scripts/backup-automation.sh" << 'EOF'
#!/bin/bash

# Automated Backup Script for GlobalTech Infrastructure
# This script performs backups of critical systems and uploads to S3

set -e

# Configuration
BACKUP_DIR="/var/backups"
S3_BUCKET="globaltech-production-backups"
RETENTION_DAYS=30
LOG_FILE="/var/log/backup-automation.log"
DATE=$(date +%Y-%m-%d-%H%M%S)

# Logging function
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# Error handling
error_exit() {
    log "ERROR: $1"
    exit 1
}

log "Starting backup process..."

# Create backup directory
mkdir -p "$BACKUP_DIR/$DATE" || error_exit "Failed to create backup directory"

# Backup PostgreSQL databases
log "Backing up PostgreSQL databases..."
pg_dumpall -U postgres | gzip > "$BACKUP_DIR/$DATE/postgresql-all-$DATE.sql.gz" || error_exit "PostgreSQL backup failed"

# Backup application configuration files
log "Backing up configuration files..."
tar -czf "$BACKUP_DIR/$DATE/config-$DATE.tar.gz" \
    /etc/httpd \
    /etc/nginx \
    /etc/postgresql \
    /opt/app/config \
    2>/dev/null || log "Warning: Some config files may not exist"

# Backup EFS data
log "Backing up EFS data..."
tar -czf "$BACKUP_DIR/$DATE/efs-data-$DATE.tar.gz" /mnt/efs || log "Warning: EFS backup incomplete"

# Calculate backup size
BACKUP_SIZE=$(du -sh "$BACKUP_DIR/$DATE" | cut -f1)
log "Backup size: $BACKUP_SIZE"

# Upload to S3
log "Uploading backups to S3..."
aws s3 sync "$BACKUP_DIR/$DATE/" "s3://$S3_BUCKET/$DATE/" \
    --storage-class STANDARD_IA \
    --sse AES256 || error_exit "S3 upload failed"

# Verify upload
log "Verifying S3 upload..."
aws s3 ls "s3://$S3_BUCKET/$DATE/" || error_exit "S3 verification failed"

# Clean up old local backups
log "Cleaning up old local backups..."
find "$BACKUP_DIR" -type d -mtime +7 -exec rm -rf {} + 2>/dev/null || true

# Clean up old S3 backups
log "Cleaning up old S3 backups..."
CUTOFF_DATE=$(date -d "$RETENTION_DAYS days ago" +%Y-%m-%d)
aws s3 ls "s3://$S3_BUCKET/" | while read -r line; do
    BACKUP_DATE=$(echo "$line" | awk '{print $2}' | tr -d '/')
    if [[ "$BACKUP_DATE" < "$CUTOFF_DATE" ]]; then
        log "Deleting old backup: $BACKUP_DATE"
        aws s3 rm "s3://$S3_BUCKET/$BACKUP_DATE/" --recursive
    fi
done

# Send notification
log "Sending backup completion notification..."
aws sns publish \
    --topic-arn "arn:aws:sns:us-east-1:123456789012:infrastructure-alerts" \
    --subject "Backup Completed Successfully" \
    --message "Backup completed at $(date). Size: $BACKUP_SIZE"

log "Backup process completed successfully"
exit 0
EOF

chmod +x "$BASE_DIR/cloud-infrastructure/scripts/backup-automation.sh"

# Create health-check.sh
cat > "$BASE_DIR/cloud-infrastructure/scripts/health-check.sh" << 'EOF'
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
EOF

chmod +x "$BASE_DIR/cloud-infrastructure/scripts/health-check.sh"

# Create disaster-recovery.sh
cat > "$BASE_DIR/cloud-infrastructure/scripts/disaster-recovery.sh" << 'EOF'
#!/bin/bash

# Disaster Recovery Script
# Automates recovery procedures for infrastructure failures

set -e

LOG_FILE="/var/log/disaster-recovery.log"
BACKUP_BUCKET="globaltech-production-backups"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

error_exit() {
    log "ERROR: $1"
    exit 1
}

# Function to restore database
restore_database() {
    local backup_date=$1
    log "Restoring database from backup: $backup_date"
    
    aws s3 cp "s3://$BACKUP_BUCKET/$backup_date/postgresql-all-$backup_date.sql.gz" /tmp/ || error_exit "Failed to download database backup"
    
    gunzip < "/tmp/postgresql-all-$backup_date.sql.gz" | psql -U postgres || error_exit "Database restore failed"
    
    log "Database restored successfully"
}

# Function to restore configuration
restore_configuration() {
    local backup_date=$1
    log "Restoring configuration from backup: $backup_date"
    
    aws s3 cp "s3://$BACKUP_BUCKET/$backup_date/config-$backup_date.tar.gz" /tmp/ || error_exit "Failed to download config backup"
    
    tar -xzf "/tmp/config-$backup_date.tar.gz" -C / || error_exit "Config restore failed"
    
    log "Configuration restored successfully"
}

# Function to failover to DR site
failover_to_dr() {
    log "Initiating failover to DR site..."
    
    # Update Route53 to point to DR
    aws route53 change-resource-record-sets \
        --hosted-zone-id Z1234567890ABC \
        --change-batch file:///opt/scripts/dr-failover-route53.json || error_exit "Route53 update failed"
    
    # Start DR instances
    aws ec2 start-instances --instance-ids $(aws ec2 describe-instances \
        --filters "Name=tag:Environment,Values=dr" "Name=instance-state-name,Values=stopped" \
        --query 'Reservations[].Instances[].InstanceId' --output text) || error_exit "Failed to start DR instances"
    
    log "Failover to DR site completed"
}

# Main recovery logic
case "$1" in
    database)
        restore_database "$2"
        ;;
    config)
        restore_configuration "$2"
        ;;
    failover)
        failover_to_dr
        ;;
    full)
        log "Starting full disaster recovery..."
        restore_database "$2"
        restore_configuration "$2"
        log "Full recovery completed"
        ;;
    *)
        echo "Usage: $0 {database|config|failover|full} [backup-date]"
        exit 1
        ;;
esac

log "Disaster recovery operation completed successfully"
EOF

chmod +x "$BASE_DIR/cloud-infrastructure/scripts/disaster-recovery.sh"

echo "All infrastructure scripts created successfully!"
EOF

chmod +x "$BASE_DIR/generate-all-files.sh"
bash "$BASE_DIR/generate-all-files.sh"

# Made with Bob
