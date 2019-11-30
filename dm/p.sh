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
        if [ -e /tmp/pamute.txt ]; then
            pactl set-sink-volume 0 "$(cat /tmp/pamute.txt)"
            rm /tmp/pamute.txt
        else
            pactl set-sink-volume 0 0%
            pactl list sinks | grep -oE '[0-9]{1,}%.*[0-9]{1,}%' |
                grep -oE '^[0-9]{1,}%' >/tmp/pamute.txt
        fi
        break

        ;;
    *)
        break
        ;;
    esac

done
