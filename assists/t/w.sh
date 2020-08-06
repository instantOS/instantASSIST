#!/usr/bin/env bash

# assist: switch wm , EXPERIMENTAL

WMSELECT="$(cat /usr/share/instantassist/menus/data/wm | instantmenu -c -l 10 -p 'select window manager')"

if [ -z "$WMSELECT" ]; then
    exit
fi

if command -v "$WMSELECT" &>/dev/null; then
    echo "setting the wm to $WMSELECT"
    echo "$WMSELECT" >/tmp/wmoverride
    sleep 0.2
    killwm
else
    notify-send "[instantASSIST] $WMSELECT is not installed"
fi
