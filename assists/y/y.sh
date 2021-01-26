#!/usr/bin/env bash

# assist: download audio from clipboard link

instantinstall youtube-dl || exit 1

LINK="$(/usr/share/instantassist/utils/y.sh)"
if [ -z "$LINK" ]; then
    echo "couldn't get link"
    notify-send -a instantASSIST "please copy a video link to clipboard"
    exit 1
fi

mkdir -p "$(xdg-user-dir MUSIC)" &>/dev/null
cd "$(xdg-user-dir MUSIC)" || exit 1
notify-send -a instantASSIST ' downloading audio'
youtube-dl --format bestaudio --add-metadata --playlist-items 1 -x "$LINK" || exit
