#!/bin/bash

# assist: rename current window

NEWNAME="$(echo '' | instantmenu -h -1 -p 'rename window' -c -bw 4)"
[ -z "$NEWNAME" ] && exit
sleep 0.2
xdotool getactivewindow set_window --name "$NEWNAME"
