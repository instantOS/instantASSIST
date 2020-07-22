#!/bin/bash

# assist: set redshift brightness

BRIGHTNESS=$(echo '' | instantmenu -p 'set redshift brightness')
[ -z "$BRIGHTNESS" ] && exit

instantinstall redshift
if grep -q '^[0-9]*\.[0-9]*$' <<<"$BRIGHTNESS"; then
    pgrep redshift && pkill redshift
    redshift -b "$BRIGHTNESS"
elif grep -q '^1$' <<<"$BRIGHTNESS"; then
    echo "quitting redshift"
    pgrep redshift && pkill redshift
else
    echo "invalid redshift input"
    notify-send "enter a value between 0 and 1"
fi
