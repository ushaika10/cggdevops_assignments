#!/bin/bash

# Get the name of the primary network interface (usually 'eth0' or 'ens33' or 'wlan0')
INTERFACE=$(ip route show default | awk '/default/ {print $5}')

# Check if the interface exists
if [ -z "$INTERFACE" ]; then
  echo "No active network interface found."
  exit 1
fi

# Get the MAC address of the interface
MAC_ADDRESS=$(cat /sys/class/net/$INTERFACE/address)

# Print the MAC address
if [ -z "$MAC_ADDRESS" ]; then
  echo "MAC address not found for interface $INTERFACE."
else
  echo "MAC Address for $INTERFACE: $MAC_ADDRESS"
fi
