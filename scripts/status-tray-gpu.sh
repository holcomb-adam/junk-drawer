#!/bin/bash

GPU_LOAD=$(cat /sys/class/drm/card1/device/gpu_busy_percent)
#GPU_TEMP_INT=$(sensors -j | jq -r '.["amdgpu-pci-0d00"].junction.temp2_input')
#GPU_TEMP=${GPU_TEMP_INT:0:2}
GPU_TEMP=*0

echo "<span foreground='#d92f29'>GPU: $GPU_LOAD% $GPU_TEMP°C</span>"

