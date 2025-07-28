#!/bin/bash
current_layout=$(setxkbmap -query | grep layout | awk '{print $2}')
if [ "$current_layout" = "it" ]; then
    setxkbmap us
    notify-send "Keyboard Layout" "Switched to English (US)" -i input-keyboard
else
    setxkbmap it
    notify-send "Layout Tastiera" "Cambiato in Italiano" -i input-keyboard
fi
