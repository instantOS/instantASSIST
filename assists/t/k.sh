#!/bin/bash

# assist: change the keyboard layout
if [ -n "$1" ]; then
    sidebar() {
        instantmenu -l 2000 -w 400 -i -h 60 -x 100000 -y 0 -bw 4 -H -q "keyboard layout"
    }
else
    sidebar() {
        instantmenu -l 30 -p "select keyboard layout"
    }
fi

LAYOUTLIST="$(localectl list-x11-keymap-layouts)"

if [ -n "$1" ]; then
    LAYOUTLIST=">>h Keyboard layout selector
$LAYOUTLIST"
fi

LAYOUT=$(echo "$LAYOUTLIST" | sidebar)

if [ -n "$LAYOUT" ]; then
    echo "applying keyboard layout $LAYOUT"
    setxkbmap -layout "$LAYOUT"
    notify-send -a instantASSIST 'keyboard layout changed to '"$LAYOUT"
    iconf layout "$LAYOUT"
else
    echo "not layout selected"
    exit
fi
