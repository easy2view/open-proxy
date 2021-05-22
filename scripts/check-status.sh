#!/bin/bash

logFile=/var/log/nginx/access.log
statusFile=/usr/share/nginx/html/status.txt

getMinutes(){
	hour=$(echo $1 | cut -d':' -f1 | sed 's/^0//')
	min=$(echo $1 | cut -d':' -f2 | sed 's/^0//')
	tsM=$((hour*60+min))
	echo $tsM
}

# check uptime
uptime | grep 'min,'
if [ $? -eq 0 ]; then
	uptimeTsM=$(uptime | awk '{print $3}')
	if [ $uptimeTsM -lt 30 ]; then
		echo "new server"
		echo -n 'ok' | tee $statusFile		
		exit 0
	fi
fi

# check matches
matches=$(tail -n 500 $logFile | egrep '" 200 |" 304 0 "' | grep -v '" 200 0 "' | tail -n 100 | egrep ':10080/|:8808/|:8088/|:81/|:10000/')

if [ $? -ne 0 ]; then
	echo -n 'blocked' | tee $statusFile		
	exit 1
fi
echo "$matches"

# check last valid access
lastMatch=$(echo "$matches" | tail -n 1)
lastTs=$(echo $lastMatch | awk -F':' '{print $2":"$3}') 
lastTsM=$(getMinutes $lastTs)
echo $lastTsM

curTs=$(date "+%H:%M")
curTsM=$(getMinutes $curTs)
echo $curTsM

diff=$((curTsM - lastTsM))
echo $diff

if [ $diff -gt 30 ]; then
	echo -n 'blocked' | tee $statusFile		
elif [[ $diff -lt 0 && $diff -gt -1410 ]]; then
	echo -n 'blocked' | tee $statusFile		
else
	echo -n 'ok' | tee $statusFile		
fi


