#!/bin/bash

height=$(wc -l ~/paperbenni/menus/data/m)

if [[ $height -gt 30 ]]; then
    heightfit=30
else
    heightfit=$height
fi

LETTER="$(cat ~/paperbenni/menus/data/m | dmenu -b $heightfit | grep -o '^.')"
[ -n "$LETTER" ] || exit 0

xdotool type "$LETTER"
