#!/bin/bash

export DISPLAY=:0
INTERNAL_DISPLAY="eDP-1"
EXTERNAL_DISPLAY=$(DISPLAY=:0 su sima -c "xrandr | grep ' connected' | grep -v '$INTERNAL_DISPLAY' | awk '{print \$1}'")

DISPLAY=:0 su sima -c "xrandr --output '$INTERNAL_DISPLAY' --auto --primary"

if [[ ! -z "$EXTERNAL_DISPLAY" ]]; then
    DISPLAY=:0 su sima -c "xrandr --output '$EXTERNAL_DISPLAY' --auto --right-of '$INTERNAL_DISPLAY'"
fi

echo "Lid opened at $(date)" >> /tmp/lid-events.log
