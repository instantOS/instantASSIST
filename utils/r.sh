#!/bin/bash

# screen recording functions

killrecording() {
    recpid="$(cat /tmp/recordingpid)"
    # kill with SIGTERM, allowing finishing touches.
    kill -15 "$recpid"
    rm -f /tmp/recordingpid
    # even after SIGTERM, ffmpeg may still run, so SIGKILL it.
    sleep 4
    kill -9 "$recpid"
    exit
}

VIDEODIR="$(xdg-user-dir VIDEOS)"
[ -e "$VIDEODIR" ] || mkdir -p "$VIDEODIR" || exit 1

# screencast an area
checkrecording() {
    if [ -e /tmp/recordingpid ]; then
        notify-send "stopping recording"
        killrecording
        return 1
    fi
}

getcastname() {
    CASTNAME="$VIDEODIR/screencast-$(date '+%y%m%d-%H%M-%S').mkv"
    echo "$CASTNAME" >/tmp/recordingname
    echo "$CASTNAME"
}

areascreencast() {
    checkrecording || return 1
    slop=$(slop -f "%x %y %w %h %g %i") || return 1
    read -r X Y W H G ID < <(echo "$slop")
    ffmpeg -y \
        -f x11grab \
        -framerate 24 \
        -s "$W"x"$H" \
        -i :0.0+"$X","$Y" \
        -f alsa -i default \
        -r 30 \
        -c:v h264 -c:a flac \
        "$(getcastname)" &
    echo "$! >/"tmp/recordingpid
}

fullscreencast() {
    checkrecording || return 1
    ffmpeg -y \
        -f x11grab \
        -framerate 60 \
        -s "$(xdpyinfo | grep dimensions | awk '{print $2;}')" \
        -i :0.0 \
        -f alsa -i default \
        -r 30 \
        -c:v libx264rgb -crf 0 -preset ultrafast -c:a flac \
        "$(getcastname)" &
    echo "$! >/"tmp/recordingpid
}

convertrecording() {
    if [ -e /tmp/recordingname ] &&
        [ -e "$(cat /tmp/recordingname)" ]; then
        echo "required files for conversion found"
    else
        return 1
    fi
    if [ -e /tmp/recordingpid ]; then
        killrecording
    fi
    cd "$VIDEODIR" || return 1
    SOURCEFILE="$(cat /tmp/recordingname)"
    ffmpeg -i "$SOURCEFILE" "${SOURCEFILE#.mkv}" && rm "$SOURCEFILE"
    rm /tmp/recordingname
}
