#!/bin/bash

# assist: same as rr but convert to mp4 afterwards

DATEFILE="screencast-$(date '+%y%m%d-%H%M-%S')"
/opt/instantos/menus/dm/rr.sh "$DATEFILE"

cd "$(xdg-user-dir VIDEOS)" || exit

if [ -e "$DATEFILE.mkv" ]; then
    notify-send "converting to mp4"
    ffmpeg -i "$DATEFILE.mkv" "$DATEFILE.mp4"
    notify-send "converting done"
    rm "$DATEFILE.mkv"
else
    notify-send "recording failed"
    echo "recording failed"
fi
