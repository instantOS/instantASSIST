#!/bin/bash

# assist: Microphone toggle (on/off)

amixer -D pulse sset Capture toggle

MICSTATUS=$(amixer get Capture | grep -w -o -e "on\|off" | sort -u | tr "[a-z]" "[A-Z]")

if [ $MICSTATUS == 'OFF' ]; then
    MICICON="/usr/share/icons/Papirus-Dark/symbolic/status/microphone-sensitivity-muted-symbolic.svg"
fi

if [ $MICSTATUS == 'ON' ]; then
    MICICON="/usr/share/icons/Papirus-Dark/symbolic/status/microphone-sensitivity-high-symbolic.svg"
fi

notify-send --expire-time 1500 --icon="$MICICON" "Microphone is $MICSTATUS now"