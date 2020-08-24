#!/usr/bin/env bash

# assist: take a screenshot and upload it to imgur

G=$(slop -f "%g") || exit 1

SCROTNAME="$(date '+%Y%m%d%H%M%S')"
PICTUREDIR="$(xdg-user-dir PICTURES)"
import -window root -crop "$G" "$PICTUREDIR/$SCROTNAME".png
notify-send '[instantASSIST] uploading screenshot'
if ping -c 1 archlinux.org; then
    IMGURLINK="$(imgur.sh "$PICTUREDIR/$SCROTNAME".png | head -1)"
    notify-send "copied imgur link: $IMGURLINK"
    echo "$IMGURLINK" | xclip -selection c
else
    notify-send 'upload failed'
fi
