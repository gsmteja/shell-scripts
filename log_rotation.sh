#!/bin/bash

# Variables
log_dir="/var/log/myapp"
log_file="/var/log/myapp/Log_rotation.log"

#Ensure log directory exist
if [ ! -d "${log_dir}" ];  then
    echo " [$(date)] ERROR! Log Directory doesn't exist" >> "${log_file}"
fi

# compress logs older then 7 days
find "$log_dir" -type f -name "*.log" -mtime +7 -mtime -30  -exec gzip {} \; -exec echo "[$(date)] Compressed Successfully" >> "$log_file" \;

#delete the files zip files older then 30 days
find "$log_dir" -type f -name "*.gz" -mtime +30 -exec rm -f {} \; -exec echo "$(date) Logs older thean 30days Deleted: {}" >> "$log_file" \;

echo "$(date) log roatation complted successfully." >> "$log_file"
