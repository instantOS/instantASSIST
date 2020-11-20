#!/usr/bin/env bash

# assist: screenshot a selected area and open it in a preview window

G=$(slop -f "%g") || exit 1

SCDIR="/tmp/instantos/screenshot/$(whoami)"

mkdir -p "$SCDIR"

import -window root -crop "$G" "$SCDIR"/tmp.png
feh "$SCDIR"/tmp.png
