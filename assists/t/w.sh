#!/bin/bash

# assist: switch wm , EXPERIMENTAL

WMSELECT="$(instantmenu -c -l 10 -p 'select window manager' </usr/share/instantassist/menus/data/wm)"

if [ -z "$WMSELECT" ]; then
    exit
fi

if command -v "$WMSELECT" &>/dev/null; then
    echo "setting the wm to $WMSELECT"
    echo "$WMSELECT" >/tmp/wmoverride
    sleep 0.2
    killwm
else
    notify-send -a instantASSIST " $WMSELECT is not installed"
fi
