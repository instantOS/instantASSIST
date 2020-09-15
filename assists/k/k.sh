#!/bin/bash

# assist: math keyboard

height=$(wc -l </usr/share/instantassist/data/m)

if [[ "$height" -gt 30 ]]; then
    heightfit=30
else
    heightfit="$height"
fi

LETTER=$(instantmenu -i -b -l "$heightfit" </usr/share/instantassist/data/m | grep -o '^.')
[ -n "$LETTER" ] || exit 0

xdotool type "$LETTER"
