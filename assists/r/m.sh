#!/bin/bash

# assist: same as rr but convert to mp4 afterwards
if [ -e /tmp/recordingpid ]; then
    pgrep ffmpeg && /usr/share/instantassist/assists/r/r.sh
    DATEFILE="$(cat /tmp/instantassistvideoname)"
    cd "$(xdg-user-dir VIDEOS)" || exit
    if [ -e "$DATEFILE.mkv" ]; then
        notify-send -a instantASSIST "converting to mp4"
        ffmpeg -i "$DATEFILE.mkv" "$DATEFILE.mp4"
        notify-send -a instantASSIST "converting done"
        rm "$DATEFILE.mkv"
        rm /tmp/instantassistvideoname
    else
        notify-send -a instantASSIST "recording failed"
        rm /tmp/instantassistvideoname
    fi
    exit
fi

DATEFILE="screencast-$(date '+%y%m%d-%H%M-%S')"
echo "$DATEFILE" >/tmp/instantassistvideoname

/usr/share/instantassist/assists/r/r.sh "$DATEFILE"
