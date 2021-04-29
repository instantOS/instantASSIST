#!/usr/bin/env bash

# assist: "freeze" part of the screen

G=$(instnatslop -f "%g") || exit 1

SCDIR="/tmp/instantos/screenshot/$(whoami)"

mkdir -p "$SCDIR"

PICNAME="$(date "+%s")".png

import -window root -crop "$G" "$SCDIR"/"$PICNAME"

# make feh floating
instantwmctrl specialnext 1
feh --title "instantASSIST screen freeze" --geometry "$G" "$SCDIR"/"$PICNAME" &
sleep 1

rm "$SCDIR"/"$PICNAME"

