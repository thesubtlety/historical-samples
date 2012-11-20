#!/bin/bash
#This script will yahoo finance every
#so often and upon recieving a suitable stock
#price, email me.

#add functionality to search for stock name
#replace COF with user input
#search the site for the spand id='xyz' that is in grep below
#search the <h2> tag for the full name

url='finance.yahoo.com/q?s=COF&ql=1'
DESIRED_PRICE=60
STOCK_PRICE=0
WAIT_TIME=300

while [ true ]; do

DATE=$(date)
HOUR=$(date +%H)

  if [[ $HOUR -eq 10 ||  $HOUR -eq 15 ]]; then

  stock_price="$(lynx -source $url | grep -o 'yfs_l84_cof.......' | sed 's/yfs_l84_cof">//' )"
  echo $STOCK_PRICE > /tmp/stock_price

  echo
  echo $date
  echo "Capital One Financial Corp. (COF)"
  echo "Stock Price: " $STOCK_PRICE

  if  [[ ${STOCK_PRICE%%.*} -gt ${DESIRED_PRICE%%.*} ]] ; then 
      thunderbird -compose "to='email',subject='COF Price',body='The COF Stock Price is now $(cat /tmp/stock_price)'" 
      sleep 2
      xdotool search --name "Write: COF Price" windowactivate key ctrl+Return
      exit 1;
  fi

fi

echo

sleep $WAIT_TIME
done

exit 0
