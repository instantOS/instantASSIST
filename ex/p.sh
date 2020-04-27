#!/bin/bash

# assist: adjust audio volume

if ! [ -e /tmp/instantos/pasink ]
then
	mkdir /tmp/instantos
	if [ "$(pactl list sinks | grep -Ei '(sink|ziel)' | wc -l)" = 1 ]
	then
		echo "single sink detected"
		pactl list sinks | grep -Ei '(sink|ziel)' | grep -o '[0-9]*' > /tmp/instantos/pasink
	else
		echo "attempting multi sink detection"
		pactl list sinks | pcregrep -iM ".*(sink|ziel).*\n.*running" | head -1 | grep -o '[0-9]*' > /tmp/instantos/pasink
	fi
fi

PSINK="$(cat /tmp/instantos/pasink | grep -o '[0-9]*')"

pvolume() {
    pactl set-sink-volume "$PSINK" "$1"
}

while :; do
	# either instantmenu or args
    if [ -n "$1" ]; then
        CHOICE="$1"
    else
        CHOICE=$(echo '+
-
j
k
m
q' | instantmenu -n)

    fi

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

    [ -n "$1" ] && break
done
