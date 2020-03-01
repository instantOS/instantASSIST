#!/bin/bash

# assist: type emojis or special symbols

height=$(wc -l < /opt/instantos/menus/data/m)

if [[ "$height" -gt 30 ]]; then
    heightfit=30
else
    heightfit="$height"
fi

LETTER=$(cat /opt/instantos/menus/data/m | instantmenu -b -l "$heightfit" | grep -o '^.')
[ -n "$LETTER" ] || exit 0

xdotool type "$LETTER"
