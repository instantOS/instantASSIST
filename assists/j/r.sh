#!/bin/bash

# assist: random number

MIN="$(echo 0 | instantmenu -p 'from')"
MAX="$(echo 10 | instantmenu -p 'to')"

if [ $MIN -gt $MAX ] || [ $MIN -eq $MAX ]
then
    notify-send "nonlogical input"
    exit
fi

OUTPUT="$(( ( RANDOM % $MAX ) + $MIN ))"

CHOICE="$(echo ">>h Output: $OUTPUT
:b Copy to clipboard
:r Close" | instantmenu -h -1 -l 20 -q "Random number")"

case "$CHOICE" in
    *clipboard)
        echo "$OUTPUT" | xclip -selection c
        notify-send "copied $OUTPUT to clipboard"
        ;;
esac
