#!/bin/bash

# assist: set up screen recordings with ffmpeg, allowing you to choose an area

DATEFILE="screencast-$(date '+%y%m%d-%H%M-%S')"
screencast() {
    ffmpeg -y \
        -f x11grab \
        -framerate 24 \
        -s "$W"x"$H" \
        -i :0.0+$X,$Y \
        -f alsa -i default \
        -r 30 \
        -c:v h264 -c:a flac \
        "$(xdg-user-dir VIDEOS)/$1.mkv" &
    echo $! >/tmp/recordingpid
}

killrecording() {
    recpid="$(cat /tmp/recordingpid)"
    # kill with SIGTERM, allowing finishing touches.
    kill -15 "$recpid"
    rm -f /tmp/recordingpid
    # even after SIGTERM, ffmpeg may still run, so SIGKILL it.
    sleep 3
    kill -9 "$recpid"
    exit
}

if [ -e /tmp/recordingpid ]; then
    killrecording
    exit
    exit
fi

slop=$(slop -f "%x %y %w %h %g %i") || exit 1
read -r X Y W H G ID < <(echo "$slop")
echo "r" >~/.status

screencast "${1:-$DATEFILE}"
