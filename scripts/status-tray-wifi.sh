#!/bin/bash

DEVICE_NAME=wlan0
NETWORK_NAME=$(iwctl station $DEVICE_NAME show | grep 'Connected network' | awk '{print $3}')
echo -n "<span foreground='#2cd443'>$DEVICE_NAME: $NETWORK_NAME</span>"
