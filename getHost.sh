
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
