#!/bin/bash
# control pulseaudio volume from instantmenu if you don't have the hardware keys or pa-applet

PSINK=$(pactl list sinks | pcregrep -iM "sink.*\n.*running" | head -1 | grep -o '[0-9]*)

pvolume() {
    pactl set-sink-volume $PSINK "$1"; then
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
            pactl set-sink-mute $PSINK toggle

        fi
        break
        ;;
    *)
        break
        ;;
    esac

done
