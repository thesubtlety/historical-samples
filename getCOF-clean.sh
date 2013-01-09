#!/bin/bash
#***********************************************************
# getCOF.sh - thesubtlety - Nov 20, 2012
# 
# This script polls yahoo finance every
# so often (3 hours) and upon recieving a suitable stock
# price, emails me. Very hacky and no robustness..
#
# TO DO
# >add functionality to search for stock name
# >replace COF with user input
# >search the site for the spand id='xyz' that is in grep below
# >search the <h2> tag for the full name
#
#**********************************************************

URL='finance.yahoo.com/q?s=COF&ql=1'
DESIRED_PRICE=60
STOCK_PRICE=0
WAIT_TIME=10800

while [ true ]; do

DATE=$(date)
HOUR=$(date +%H)

# Pulls down the source from the COF finance page. the yfs_l84 seems to be unique for the 
# stock price. I'm assuming each stock has its own id
STOCK_PRICE="$(lynx -source $URL | grep -o 'yfs_l84_cof.......' | sed 's/yfs_l84_cof">//' )"
echo $STOCK_PRICE > /tmp/stock_price

echo
echo $DATE
echo "Capital One Financial Corp. (COF)"
echo "Stock Price: " $STOCK_PRICE

# Once the price is higher than I specify, emails me
if  [[ ${STOCK_PRICE%%.*} -gt ${DESIRED_PRICE%%.*} ]] ; then 
    thunderbird -compose "to='email',subject='COF Price',body='The COF Stock Price is now $(cat /tmp/stock_price)'" 
    sleep 2
    xdotool search --name "Write: COF Price" windowactivate key ctrl+Return
    exit 1;
fi

sleep $WAIT_TIME
done

exit 0
