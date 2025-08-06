#!/bin/bash
# Toggle Bluetooth power state

# Get current power state
if bluetoothctl show | grep -q "Powered: yes"; then
    # Bluetooth is on, turn it off
    bluetoothctl power off
else
    # Bluetooth is off, turn it on
    bluetoothctl power on
fi
