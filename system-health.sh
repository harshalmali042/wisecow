#!/bin/bash

# Thresholds
CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=80
LOG_FILE="/var/log/system_health.log"

# Functions
log_alert() {
    echo "$(date): $1" | tee -a $LOG_FILE
}

# CPU Usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
CPU_USAGE=${CPU_USAGE%.*}
if [ "$CPU_USAGE" -gt "$CPU_THRESHOLD" ]; then
    log_alert "High CPU Usage: ${CPU_USAGE}%"
fi

# Memory Usage
MEM_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
MEM_USAGE=${MEM_USAGE%.*}
if [ "$MEM_USAGE" -gt "$MEM_THRESHOLD" ]; then
    log_alert "High Memory Usage: ${MEM_USAGE}%"
fi

# Disk Usage (/ partition)
DISK_USAGE=$(df / | grep / | awk '{print $5}' | sed 's/%//')
if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
    log_alert "High Disk Usage: ${DISK_USAGE}%"
fi
