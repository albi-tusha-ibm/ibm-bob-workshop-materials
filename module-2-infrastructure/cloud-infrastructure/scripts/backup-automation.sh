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
