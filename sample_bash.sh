#!/usr/bin/env bash
#
#

#check if my 8080 port is in consumpution or not
#

netstat -ntpl | grep 8080 > /dev/null
if [[ $? -eq 0 ]]; 
then
	echo "Port 8080 is in use"
else 
	echo "port 8080 is not in use"
fi
