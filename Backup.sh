#!/bin/bash

SOURCE_DIR="/home/ubuntu/data"
USER="ubuntu"
HOST_IP="192.168.1.100"
BACKUP_DIR="/backups/data"
LOG_FILE="/var/log/backup.log"
DATE=$(date +%F_%T)

echo " Backup started at $DATE " | tee -a "$LOG_FILE"

rsync -avz --delete "$SOURCE_DIR" "${USER}@${HOST_IP}:${BACKUP_DIR}" >> "$LOG_FILE" 2>&1

if [ $? -eq 0 ]; then
    echo "$(date): Backup Successful" | tee -a "$LOG_FILE"
else
    echo "$(date): Backup Failed!" | tee -a "$LOG_FILE"
fi

echo " Backup completed at $(date +%F_%T) " | tee -a "$LOG_FILE"
