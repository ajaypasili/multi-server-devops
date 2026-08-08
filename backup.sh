#!/bin/bash

set -e

# -----------------------------
# Configuration
# -----------------------------

DATE=$(date +"%Y-%m-%d_%H-%M-%S")

APP_DIR="/opt/multi-server-devops"

BACKUP_DIR="/opt/backups"

REMOTE_USER="devops"

REMOTE_HOST="3.7.122.22"

REMOTE_DIR="/opt/backups"

SSH_KEY="/home/devops/.ssh/india_backup_key"

BACKUP_FILE="application-${DATE}.tar.gz"


# -----------------------------
# Create backup directory
# -----------------------------

mkdir -p "$BACKUP_DIR"


# -----------------------------
# Create compressed backup
# -----------------------------

tar -czf "$BACKUP_DIR/$BACKUP_FILE" \
    "$APP_DIR"


# -----------------------------
# Transfer backup to India
# -----------------------------

rsync -avz \
    -e "ssh -i $SSH_KEY -o StrictHostKeyChecking=no" \
    "$BACKUP_DIR/$BACKUP_FILE" \
    "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR/"


# -----------------------------
# Delete backups older than 7 days
# -----------------------------

find "$BACKUP_DIR" \
    -type f \
    -name "*.tar.gz" \
    -mtime +7 \
    -delete


echo "Backup completed successfully."

echo "Backup file: $BACKUP_FILE"
