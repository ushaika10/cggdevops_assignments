#!/bin/bash

# Script to get details of top 5 high CPU consuming processes

echo "Top 5 high CPU consuming processes:"
echo "-----------------------------------"

# Use ps to list processes, sort by CPU usage, and display the top 5
ps -eo pid,ppid,cmd,%cpu,%mem --sort=-%cpu | head -n 6

# Explanation:
# - ps -eo pid,ppid,cmd,%cpu,%mem: List processes with specified fields
#   - pid: Process ID
#   - ppid: Parent Process ID
#   - cmd: Command line
#   - %cpu: CPU usage
#   - %mem: Memory usage
# --sort=-%cpu: Sort by CPU usage in descending order
# head -n 6: Display the first 6 lines (header + top 5 processes)
