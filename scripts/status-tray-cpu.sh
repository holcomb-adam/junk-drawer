#!/bin/bash

# Using grep because jq doesnt like "sensors -j"'s bad json
#CPU_TEMP_INT=$(sensors -u | pcregrep -M "CPU:*\n.*temp2_input:" | awk '{print $2}')
#CPU_TEMP=${CPU_TEMP_INT:1:2}
CPU_TEMP=*0

CPU_INFO=$(cat /proc/stat | grep cpu | head -n 1)
CPU_IDLE=$(echo $CPU_INFO | awk '{print $5 + $6}')
CPU_TOTAL=$(echo $CPU_INFO | awk '{print $2 + $3 + $4 + $7 + $8 + $9}')
let CPU_LOAD=CPU_IDLE/CPU_TOTAL

echo "<span foreground='#3574db'>CPU: ${CPU_LOAD}%* ${CPU_TEMP}°C</span>"
