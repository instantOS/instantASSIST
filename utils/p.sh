#!/bin/bash

# assist: adjust audio volume

pvolume() {
    amixer set Master "$1" &>/dev/null || amixer -D pulse set Master "$1"
}

if [ "$1" -eq "$1" ] &>/dev/null; then
    pamixer --set-volume "$1" || pvolume "${1}%"
    exit
fi

displayvolume() {
    VOLUME="$(pamixer --get-volume || {
        awk -F"[][]" '/Left:/ { print $2 }' <(amixer sget Master) | grep -o '[0-9]*'
    })"
    dunstify -i -a instantASSIST '/usr/share/icons/Papirus-Dark/symbolic/status/audio-volume-medium-symbolic.svg' -h int:value:"$VOLUME" Volume
}

case "$1" in
+)
    pamixer -i 5 || pvolume 5%+
    displayvolume
    ;;
-)
    pamixer -d 5 || pvolume 5%-
    displayvolume
    ;;
j)
    pamixer -d 5 || pvolume 5%-
    displayvolume
    ;;
k)
    pamixer -i 5 || pvolume 5%+
    displayvolume
    ;;
m)
    if iconf -i mute; then
        iconf -i mute 0
        pamixer -u || {
            amixer set Master unmute || amixer -D pulse set Master unmute
            amixer set Headphone unmute || amixer -D pulse set Headphone unmute
            amixer set Speaker unmute || amixer -D pulse set Speaker unmute
        }
    else
        iconf -i mute 1
        pamixer -m || {
            amixer set Master mute || amixer -D pulse set Master mute
            amixer set Headphone mute || amixer -D pulse set Headphone mute
            amixer set Speaker mute || amixer -D pulse set Speaker mute
        }
    fi
    ;;
*)
    echo "not setting audio"
    ;;
esac
