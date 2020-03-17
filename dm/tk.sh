#!/bin/bash

# assist: change the keyboard layout

LAYOUT=$(localectl list-x11-keymap-layouts | instantmenu -l 30 -p "select keyboard layout")

if [ -n "$LAYOUT" ]; then
    echo "applying keyboard layout $LAYOUT"
    setxkbmap -layout "$LAYOUT"
    mkdir -p ~/instantos/
    notify-send '[instantASSIST] keyboard layout changed to '"$LAYOUT"
    echo "$LAYOUT" >~/instantos/keyboard
else
    echo "not layout selected"
    exit
fi
