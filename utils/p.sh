#!/bin/bash

# assist: adjust audio volume

pvolume() {
    amixer set Master "$1" &>/dev/null || amixer -D pulse set Master "$1"
}

if [ "$1" -eq "$1" ] &>/dev/null; then
    pvolume "${1}%"
    exit
fi

case "$1" in
+)
    pvolume 5%+
    ;;
-)
    pvolume 5%-
    ;;
j)
    pvolume 5%-
    ;;
k)
    pvolume 5%+
    ;;
m)
    if iconf -i mute
    then
        iconf -i mute 0
        amixer set Master unmute
        amixer set Headphone unmute
        amixer set Speaker unmute
    else
        iconf -i mute 1
        amixer set Master mute
        amixer set Headphone mute
        amixer set Speaker mute
    fi
    ;;
*)
    echo "not setting audio"
    ;;
esac
