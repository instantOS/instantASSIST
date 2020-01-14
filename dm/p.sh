#!/bin/bash
# control pulseaudio volume from instantmenu if you don't have the hardware keys or pa-applet

pvolume() {
    if ! pactl set-sink-volume 0 "$1"; then
        pactl set-sink-volume $(pactl list sinks | head -1 | grep -o '[0-9]*') "$1"
    fi
}

while :; do
    CHOICE=$(echo '+
-
j
k
m
q' | instantmenu -n)

    if [ "$CHOICE" -eq "$CHOICE" ] &>/dev/null; then
        pvolume "$CHOICE"%
        break
    fi

    case "$CHOICE" in
    +)
        pvolume +5%
        ;;
    -)
        pvolume -5%
        ;;
    j)
        pvolume -5%
        ;;
    k)
        pvolume +5%
        ;;
    m)
        if ! pactl set-sink-mute 0 toggle; then
            pactl set-sink-mute $(pactl list sinks | head -1 | grep -o '[0-9]*') toggle

        fi
        break
        ;;
    *)
        break
        ;;
    esac

done
