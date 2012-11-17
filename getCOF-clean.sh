#!/bin/bash
#This script will yahoo finance every
#so often and upon recieving a suitable stock
#price, email me.

#TO DO
#add functionality to search for stock name
#replace COF with user input
#search the site for the spand id='xyz' that is in grep below
#search the <h2> tag for the full name

url='finance.yahoo.com/q?s=COF&ql=1'
desired_price=60
stock_price=0
wait_time=21600
date=$(date)

while [ true ]; do

stock_price="$(lynx -source $url | grep -o 'yfs_l84_cof.......' | sed 's/yfs_l84_cof">//' )"
echo $stock_price > /tmp/stock_price

echo
echo $date
echo "Capital One Financial Corp. (COF)"
echo "Stock Price: " $stock_price

if  [[ ${stock_price%%.*} -gt ${desired_price%%.*} ]] ; then 
    thunderbird -compose "to='email-address',subject='COF Price',body='The COF Stock Price is now $(cat /tmp/stock_price)'" 
    sleep 2
    xdotool search --name "Write: COF Price" windowactivate key ctrl+Return
    exit 1;
fi

echo

sleep $wait_time
done

exit 0
