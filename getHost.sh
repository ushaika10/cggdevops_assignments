#!/usr/bin/env bash 
#

# check if hostname file exists on the VM

if [[ -f /etc/hostname ]];
then
	echo "file hostname exists"
	cat /etc/hostname
else
	echo "Flie not found on the server"
	exit 1 
fi
