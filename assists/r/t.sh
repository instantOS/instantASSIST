#!/bin/bash

# assist: record and upload a terminal session to showterm.io

instantutils open terminal -e bash -c 'bash <(cat /usr/share/instantassist/utils/t.sh)'

if [ -e /tmp/showtermrecordinglink ]; then
    LINK="$(cat /tmp/showtermrecordinglink)"
    echo "$LINK" | xclip -selection c
    notify-send "copied $LINK to clipboard"
else
    notify-send 'upload failed'
fi
