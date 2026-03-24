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
