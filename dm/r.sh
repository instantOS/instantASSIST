#!/bin/bash
if pgrep ffmpeg; then
    pkill ffmpeg
    exit 0
fi

slop=$(slop -f "%x %y %w %h %g %i") || exit 1
read -r X Y W H G ID < <(echo $slop)
ffmpeg -framerate 30 -f x11grab -s "$W"x"$H" -i :0.0+$X,$Y -f alsa -i pulse -vcodec libx264 ~/paperbenni/recordings/$(date '+%Y%m%d%H%M%S').mkv
