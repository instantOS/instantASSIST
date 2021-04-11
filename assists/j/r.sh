#!/bin/bash

# assist: random number from range

MIN="$(echo 0 | instantmenu -p 'from')"
MAX="$(echo 1 | instantmenu -p 'to')"

if [ "$MIN" -gt "$MAX" ] || [ "$MIN" -eq "$MAX" ]; then
    notify-send "nonlogical input"
    exit
fi

if [ "$MIN" -eq 0 ]; then
    MAX=$((MAX + 1))
fi

NEWNUMBER=true
while [ -n "$NEWNUMBER" ]; do

    unset NEWNUMBER
    OUTPUT="$(((RANDOM % MAX) + MIN))"

    CHOICE="$(echo ">>h Output: $OUTPUT
:b ﱬNew number
:b Copy to clipboard
:r Close" | instantmenu -h -1 -l 20 -q "Random number" -ps 1)"

    case "$CHOICE" in
    *clipboard)
        echo "$OUTPUT" | xclip -selection c
        notify-send "copied $OUTPUT to clipboard"
        ;;
    *number)
        NEWNUMBER=true
        ;;
    esac

done
