#!/usr/bin/env bash

# assist: screenshot a selected area after 5 seconds

G=$(slop -f "%g") || exit 1
sleep 5
import -window root -crop "$G" "$(xdg-user-dir PICTURES)/$(date '+%Y%m%d%H%M%S')".png
notify-send -a instantASSIST 'screenshot taken'
