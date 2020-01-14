#!/bin/bash

if ! xbacklight &> /dev/null; then
    [ -e /etc/udev/rules.d/backlight.rules ] || exit
    BGPU="/sys/class/backlight/"$(cat /etc/udev/rules.d/backlight.rules | head -1 | \
    grep -o 'KERNEL=="[^ ]*"' | grep -o '".*"' | grep -o '[^"]*')"/brightness"
    MAXBRIGHT=$(cat ${BGPU%/*}/max_brightness)
    let "BRIGHTSTEP = $MAXBRIGHT / 20"
fi

brightness() {

    if [ -z "$BGPU" ]; then
        xbacklight "$@"
        return
    fi

    case "$1" in
    -inc)
        let "bright = $(cat $BGPU) + $2"
        if [ "$bright" -lt "$MAXBRIGHT" ] && [ "$bright" -gt 0 ]; then
            echo "$bright" >"$BGPU"
        fi
        ;;
    -dec)
        let "bright = $(cat $BGPU) - $2"
        if [ "$bright" -lt "$MAXBRIGHT" ] && [ "$bright" -gt 0 ]; then
            echo "$bright" >"$BGPU"
        fi
        ;;

    -set)
        if [ "$2" -lt "$MAXBRIGHT" ] && [ "$2" -gt 0 ]; then
            echo "$2" >"$BGPU"
        fi
        ;;

    *)
        return
        ;;

    esac

}

if [ -n "$1" ]; then
    if grep -q '^[+-]' <<<"$1"; then
        if [ "${1::1}" = "-" ]; then
            if grep -q '^[0-9]*$' <<<"${1:1}"; then
                brightness -dec "${1:1}"
            fi
        else
            if grep -q '^[0-9]*$' <<<"${1:1}"; then
                brightness -inc "${1:1}"
            fi
        fi
    else
        if grep -q '^[0-9]*$' <<<"$1"; then
            brightness -set "$1"
        fi
    fi
    exit
fi

while :; do
    CHOICE=$(echo '+
-
j
k
q' | instantmenu -n)

    if [ "$CHOICE" -eq "$CHOICE" ] &>/dev/null; then
        brightness -set "$CHOICE"
        break
    fi

    case "$CHOICE" in
    +)
        brightness -inc "${BRIGHTSTEP:-5}"
        ;;
    -)
        brightness -dec "${BRIGHTSTEP:-5}"
        ;;
    j)
        brightness -dec "${BRIGHTSTEP:-5}"
        ;;
    k)
        brightness -inc "${BRIGHTSTEP:-5}"
        ;;
    *)
        break
        ;;
    esac

done
