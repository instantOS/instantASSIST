#!/usr/bin/env bash

# assist: download video from clipboard link

instantinstall youtube-dl || exit 1

LINK="$(/usr/share/instantassist/utils/y.sh)"
if [ -z "$LINK" ]; then
    echo "couldn't get link"
    notify-send -a instantASSIST "please copy a video link to clipboard"
    exit 1
fi

mkdir -p "$(xdg-user-dir VIDEOS)" &>/dev/null
cd "$(xdg-user-dir VIDEOS)" || exit 1
notify-send -a instantASSIST ' downloading video'
youtube-dl --playlist-items 1 "$LINK" || exit
