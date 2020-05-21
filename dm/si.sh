#!/bin/bash

# assist: take a screenshot and upload it to imgur

slop=$(slop -f "%g") || exit 1
read -r G < <(echo "$slop")
SCROTNAME="$(date '+%Y%m%d%H%M%S')"
PICTUREDIR="$(xdg-user-dir PICTURES)"
import -window root -crop "$G" $PICTUREDIR/$SCROTNAME.png
notify-send '[instantASSIST] uploading screenshot'
if ping -c 1 archlinux.org; then
    IMGURNAME=$(imgur.sh $PICTUREDIR/$SCROTNAME.png)
    notify-send "copied imgur link: $IMGURNAME"
    echo "$IMGURNAME" | xclip -selection c
else
    notify-send 'upload failed'
fi
