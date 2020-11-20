#!/usr/bin/env bash

# assist: screenshot a selected area and open it in a preview window

G=$(slop -f "%g") || exit 1

SCDIR="/tmp/instantos/screenshot/$(whoami)"

mkdir -p "$SCDIR"

PICNAME="$(date "+%s")".png

import -window root -crop "$G" "$SCDIR"/"$PICNAME"

# make feh floating
instantwmctrl specialnext 1
feh --geometry "$G" "$SCDIR"/"$PICNAME" &
sleep 1

rm "$SCDIR"/"$PICNAME"

