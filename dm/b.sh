#!/bin/bash

while :; do
    CHOICE=$(echo '+
-
q' | dmenu -n)
    if [ "$CHOICE" -eq "$CHOICE" ] &>/dev/null; then
        xbacklight -set "$CHOICE"
        break
    fi

    case "$CHOICE" in
    +)
        xbacklight -inc 5
        ;;
    -)
        xbacklight -dec 5
        ;;
    j)
        xbacklight -dec 5
        ;;
    k)
        xbacklight -inc 5
        ;;
    *)
        break
        ;;
    esac

done
