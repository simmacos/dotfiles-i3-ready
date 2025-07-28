#!/bin/bash
MODE="Performance"
sudo cpupower frequency-set -g performance
sudo cpupower set --perf-bias 0
brightnessctl set 100%

GOVERNOR=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)
FREQ=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq)
FREQ_MHZ=$(echo "scale=2; $FREQ/1000" | bc)

notify-send "Power Mode: $MODE" "Governor: $GOVERNOR\nFrequency: $FREQ_MHZ MHz\nBrightness: 100%"
