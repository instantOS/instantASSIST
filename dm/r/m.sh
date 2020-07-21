#!/bin/bash

# assist: same as rr but convert to mp4 afterwards
if [ -e /tmp/instantassistvideoname ]; then
    pgrep ffmpeg && /usr/share/instantassist/menus/dm/rr.sh
    DATEFILE="$(cat /tmp/instantassistvideoname)"
    cd "$(xdg-user-dir VIDEOS)" || exit
    if [ -e "$DATEFILE.mkv" ]; then
        notify-send "converting to mp4"
        ffmpeg -i "$DATEFILE.mkv" "$DATEFILE.mp4"
        notify-send "converting done"
        rm "$DATEFILE.mkv"
        rm /tmp/instantassistvideoname
    else
        notify-send "recording failed"
        rm /tmp/instantassistvideoname
    fi
    exit
fi

DATEFILE="screencast-$(date '+%y%m%d-%H%M-%S')"
echo "$DATEFILE" >/tmp/instantassistvideoname

/usr/share/instantassist/menus/dm/rr.sh "$DATEFILE"
