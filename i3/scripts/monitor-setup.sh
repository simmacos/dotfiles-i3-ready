#!/bin/bash

# Verifica se il lid è chiuso
if grep -q closed /proc/acpi/button/lid/*/state; then
    # Disattiva lo schermo interno (eDP-1) e attiva solo lo schermo esterno (DP-2)
    xrandr --output eDP-1 --off --output DP-2 --auto --primary
else
    # Se il lid è aperto, estendi i display
    xrandr --output eDP-1 --auto --output DP-2 --auto --right-of eDP-1
fi
