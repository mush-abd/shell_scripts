#! /bin/bash
# This script sets up a cron job to run every minute
# and appends the current date to a file at /tmp/everymin.txt
# Ensure the script is executable
# Usage: ./job_scheduling.sh
cron_job="*  *   *   *   *  date >> /tmp/everymin.txt"

crontab -l 2>/dev/null | grep -q "/tmp/everymin.txt"

if [ $? -eq 0 ]; then
    echo "cronjob already exists"
else
    (crontab -l 2>/dev/null; echo "$cron_job") | crontab -
    echo "cronjob created"
fi
