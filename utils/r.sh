#!/bin/bash

# screen recording functions

killrecording() {
    notify-send "stopping recording"
    keypid="$(cat /tmp/screenkeypid)"
    [ -n "$keypid" ] && kill $keypid

    recpid="$(cat /tmp/recordingpid)"
    # kill with SIGTERM, allowing finishing touches.
    kill -15 "$recpid"
    rm -f /tmp/recordingpid
    # even after SIGTERM, ffmpeg may still run, so SIGKILL it.
    sleep 4
    kill -9 "$recpid"
}

VIDEODIR="$(xdg-user-dir VIDEOS)"
[ -e "$VIDEODIR" ] || mkdir -p "$VIDEODIR" || exit 1

# screencast an area
checkrecording() {
    if [ -e /tmp/recordingpid ]; then
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
    ffmpeg -framerate 25 -s "$W"x"$H" -f x11grab -i :0.0+"$X","$Y" -f pulse -ac 2 -i default "$(getcastname)" &
    echo "$!" >/tmp/recordingpid
}

fullscreencast() {
    checkrecording || return 1
    ffmpeg -framerate 25 -s "$(xdpyinfo | grep dimensions | awk '{print $2;}')" -f x11grab -i :0.0 -f pulse -ac 2 -i default "$(getcastname)" &
    echo "$!" >/tmp/recordingpid
}

keycast() {
    instantinstall screenkey
    if ! pgrep screenkey; then
        screenkey --no-systray & echo "$!" > /tmp/screenkeypid
    fi
}

# stop recording and convert to mp4 for quick usage on social media (usually doesn't support mkv)
convertrecording() {
    if [ -e /tmp/recordingpid ]; then
        killrecording
        sleep 2
    fi
    if [ -e /tmp/recordingname ] &&
        [ -e "$(cat /tmp/recordingname)" ]; then
        echo "required files for conversion found"
    else
        return 1
    fi
    if ! cd "$VIDEODIR"; then
        echo "video directory error"
        return 1
    fi
    SOURCEFILE="$(cat /tmp/recordingname)"
    notify-send "converting recording"
    ffmpeg -i "$SOURCEFILE" "${SOURCEFILE%.mkv}.mp4" && rm "$SOURCEFILE"
    rm /tmp/recordingname
}
