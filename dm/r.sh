#!/bin/bash

if pgrep ffmpeg; then
    if timeout 10 inotifywait --event modify ~/paperbenni/recordings; then
        pkill ffmpeg
        echo "|" > ~/.status
        exit 0
    fi
fi

slop=$(slop -f "%x %y %w %h %g %i") || exit 1
read -r X Y W H G ID < <(echo $slop)
echo "r" > ~/.status
ffmpeg -framerate 30 -f x11grab -s "$W"x"$H" -i :0.0+$X,$Y -f alsa -i pulse -vcodec libx264 ~/paperbenni/recordings/$(date '+%Y%m%d%H%M%S').mkv
