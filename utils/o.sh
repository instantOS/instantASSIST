#!/bin/bash
# assist: open file in text editor

cd || exit 1

CHOICE="$(fzf)"

if [ -n "$CHOICE" ] && [ -e "$CHOICE" ]; then
   ~/.config/instantos/default/editor "$CHOICE" &
fi

