#!/usr/bin/env bash


#get the hostanme of the machine.

hst_name=$(hostname)
if [[ $? -eq 0 ]];
then
	echo "Hostname is set for the machine"
	echo "$hst_name"
else 
	echo "unable to get the hostname of the machine"
	exit 1
fi
