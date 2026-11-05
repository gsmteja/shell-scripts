#!/bin/bash
set -u

# Variables
log_dir="/var/log/myapp"
log_file="/var/log/myapp/Log_rotation.log"

# Ensure log directory exists
if [ ! -d "${log_dir}" ]; then
    echo "[$(date)] ERROR! Log directory doesn't exist" >&2
    exit 1
fi

# Compress logs older than 7 days and newer than 30 days
find "$log_dir" -type f -name "*.log" ! -name "Log_rotation.log" -mtime +7 -mtime -30 -exec sh -c 'gzip "$1" && echo "[$(date)] Compressed: $1" >> "$2"' _ {} "$log_file" \;

# Delete logs and compressed logs older than 30 days
find "$log_dir" -type f \( -name "*.log" -o -name "*.gz" \) ! -name "Log_rotation.log" -mtime +30 -exec sh -c 'rm -f "$1" && echo "[$(date)] Deleted: $1" >> "$2"' _ {} "$log_file" \;

echo "[$(date)] Log rotation completed." >> "$log_file"