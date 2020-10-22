#!/bin/bash

# get youtube link

LINK="$(xclip -o -selection clipboard)"

newlink() {

    if ! grep -q '....' <<<"$LINK"; then
        # no link detected, attempt getting link from firefox
        if xdotool getactivewindow getwindowname | grep -iq 'mozilla firefox'; then
            xdotool key Ctrl+l
            sleep 0.1
            xdotool key Ctrl+c
            LINK="$(xclip -o -selection clipboard)"
            export LINK
        else
            exit 1
        fi
    fi
}

cleanlink() {
    # let user choose between playlist or single video
    if grep -q 'music\.youtube\.com/watch?v=.*&list=.*' <<<"$LINK"; then

        CHOICE="$(echo 'download all videos
download the current video' | imenu -C 'link is a playlist')"

        if [ -z "$CHOICE" ]; then
            notify-send "download cancelled"
            exit 1
        fi

        if echo "$CHOICE" | grep -q 'current'; then
            LINK="$(grep -o '.*music\.youtube\.com/watch?v=[^&]*' <<<"$LINK")"
        fi
    fi
}

newlink
cleanlink

[ -z "$LINK" ] && exit

if [ -e /tmp/instantos/youtube.txt ]; then
    OLDLINK="$(cat /tmp/instantos/youtube.txt)"
    if [ "$LINK" = "$OLDLINK" ]; then
        # already downloaded
        unset LINK
        newlink
        if [ "$LINK" = "$OLDLINK" ]; then
            # still on the same webpage
            exit
        fi
        cleanlink
    fi
else
    mkdir -p /tmp/instantos
fi

# exit code indicates found link
if [ -n "$LINK" ]; then
    echo "$LINK"
    echo "$LINK" > /tmp/instantos/youtube.txt
    exit 0
else
    exit 1
fi
