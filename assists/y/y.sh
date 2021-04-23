#!/usr/bin/env bash

# assist: download audio from clipboard link

instantinstall youtube-dl && \

{
LINK="$(/usr/share/instantassist/utils/y.sh)"
if [ -z "$LINK" ]; then
    echo "couldn't get link"
    notify-send -a instantASSIST "please copy a video link to clipboard"
    exit 1
fi

mkdir -p "$(xdg-user-dir MUSIC)" &>/dev/null
cd "$(xdg-user-dir MUSIC)" || exit 1
notify-send -a instantASSIST ' downloading audio'
youtube-dl --format bestaudio --add-metadata --playlist-items 1 -x "$LINK" || { notify-send -a instantASSIST " audio download failed"; exit 1;}
notify-send -a instantASSIST " audio downloaded ($(xdg-user-dir MUSIC))";
}
