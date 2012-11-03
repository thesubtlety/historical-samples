#!/bin/sh
#proclist.sh
#List basic system info, playing around with awk 

# get current time 
date=$(date)
linux_version=$(awk '{print $1 " " $2 " " $3 }' /proc/version)
memory_total=$(cat /proc/meminfo | awk '/MemTotal/ {printf( "%.2f\n", $2 / 1024/1024)}')
memory_free=$(cat /proc/meminfo | awk '/MemFree/ {printf( "%.2f\n", $2 / 1024/1024)}')
uptime=$(</proc/uptime)
uptime=${uptime%%.*}
minutes=$((uptime/60%60))
hours=$((uptime/60/60%24))
days=$((uptime/60/60/24))
procs_running=$(awk '/procs_running/ {print $2}' /proc/stat)
procs_blocked=$(awk '/procs_blocked/ {print $2}' /proc/stat)
users=$(users | wc -w)

echo  "\n************* /proc report generated " $date " ********\n"
echo  "Operating System : " $linux_version "\n"

# /proc/cpuinfo gets processor#s, vedorIds, model names and speeds in MHz
# or try fgrep "MHz" /proc/cpuinfo | awk '{print $4}'
cat /proc/cpuinfo | awk '/model name/ {print "CPU model : " $4,$5,$6,$7,$8,$9 } /cpu MHz/ {printf "@ %.2f GHz\n", $4/1000 }'

#Total memory
echo  "\nTotal memory: " $memory_total "GB"
#Free memory
echo  "Free memory: " $memory_free "GB\n"


echo "Number of users currently on system : " $users
echo  "Time since last boot (days:hours:minutes) : " $days":"$hours":"$minutes "\n"

echo  "Running processes : " $procs_running 
echo  "Blocked processes : " $procs_blocked "\n"

echo  "*************************************************************\n"

exit 0
