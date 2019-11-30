#!/bin/bash

while :; do
    CHOICE=$(echo '+
-
j
k
m
q' | dmenu -n)
    if [ "$CHOICE" -eq "$CHOICE" ] &>/dev/null; then
        xbacklight -set "$CHOICE"
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
        pactl set-sink-volume 0 0%
        ;;
    *)
        break
        ;;
    esac

done
