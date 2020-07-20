#!/bin/bash

# assist: adjust audio volume

pvolume() {
    pactl amixer set 'Master' "$1"
}

if [ "$1" -eq "$1" ] &>/dev/null; then
    pvolume "$CHOICE"
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
    amixer set 'Master' toggle
    ;;
*)
    echo "not setting audio"
    ;;
esac
