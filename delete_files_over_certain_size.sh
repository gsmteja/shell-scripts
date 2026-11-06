#!/bin/bash

# This script will deleted the files which is occupying more stace 100 Mb.

#Find command parametes Man, Find, file, 

sudo find /var/ -type f -size +100M -exec rm -i{} \; 

# Get the list of user who logged into the VM server.

last -F | grep "$(date '+%b %e')" |awk '{print $1}' | uniq