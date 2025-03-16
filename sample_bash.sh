#!/usr/bin/env bash

systemctl status tomcat > /dev/null
ext_code=$(echo $?)
if [[ $ext_code -eq 0 ]]; 
then
	echo "Tomcat is running, please check my exit code is $ext_code"
else 
	echo "Tomcat is not running below is outcome of systemctl cmd, my exit code was $ext_code"
fi 

