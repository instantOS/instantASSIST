#!/bin/bash
# control pulseaudio volume from dmenu if you don't have the hardware keys or pa-applet

while :; do
    CHOICE=$(echo '+
-
j
k
m
q' | dmenu -n)

    if [ "$CHOICE" -eq "$CHOICE" ] &>/dev/null; then
        pactl set-sink-volume 0 "$CHOICE"%
        break
    fi

    case "$CHOICE" in
    +)
        pactl set-sink-volume 0 +5%
        ;;
    -)
        pactl set-sink-volume 0 -5%
        ;;
    j)
        pactl set-sink-volume 0 -5%
        ;;
    k)
        pactl set-sink-volume 0 +5%
        ;;
    m)
        pactl set-sink-mute 0 toggle
        break
        ;;
    *)
        break
        ;;
    esac

done
