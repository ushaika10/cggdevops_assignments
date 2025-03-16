#!/usr/bin/env bash

systemctl status tomcat > /dev/null
ext_code=$(echo $?)
if [[ $ext_code -eq 0 ]]; 
then
	echo "Tomcat is running, please check my exit code is $ext_code"
else 
	echo "Tomcat is not running below is outcome of systemctl cmd, my exit code was $ext_code"
fi 

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
