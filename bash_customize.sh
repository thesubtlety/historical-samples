#!/bin/bash
# Displays greeting on bash startup
# =====================================================================

# get time and date 
hour=$(date)

#get user
login_id=${USER}-on-${HOSTNAME}

#get version number
version=$(uname -rsm)


#get disk_usage
disk_usage=$(df -lh --total |grep total | awk '{print "You are using " $3 " of " $2}')


#check if fortune is installed first
#if ! type "$fortune" > /dev/null; then
#  echo ""
#else
  greeting=$(fortune)
#fi
 
# display greeting
echo -e "\n## "$hour
echo "## "$login_id
echo "## "$version
echo -e "\n## " $disk_usage
echo -e "\n## "$greeting "\n"

