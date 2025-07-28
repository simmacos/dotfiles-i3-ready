#!/bin/bash
MODE="Balanced"
sudo cpupower frequency-set -g powersave
sudo cpupower set --perf-bias 6
brightnessctl set 50%

GOVERNOR=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)
FREQ=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq)
FREQ_MHZ=$(echo "scale=2; $FREQ/1000" | bc)

notify-send "Power Mode: $MODE" "Governor: $GOVERNOR\nFrequency: $FREQ_MHZ MHz\nBrightness: 50%"
