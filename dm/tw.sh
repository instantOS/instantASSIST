#!/bin/bash
WMSELECT"$(cat /opt/instantos/menus/data/wm | instantmenu -c -p -l 10 'select window manager')"

if command -v "$WMSELECT" &>/dev/null; then
    echo "$WMSELECT" >/tmp/wmoverride
    sleep 0.2
    killwm
fi
