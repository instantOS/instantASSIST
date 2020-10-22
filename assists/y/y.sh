#!/usr/bin/env bash

# assist: download clipboard link with youtube-dl

LINK="$(/usr/share/instantassist/utils/y.sh)"
if [ -z "$LINK" ]
then
    echo "couldn't get link"
    notify-send "please copy a video link to clipboard"
    exit 1
fi

mkdir -p "$(xdg-user-dir MUSIC)" &>/dev/null
cd "$(xdg-user-dir MUSIC)" || exit 1
notify-send '[instantASSIST] downloading audio'
youtube-dl --playlist-items 1 -x "$LINK" || exit
