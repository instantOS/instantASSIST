#!/usr/bin/env bash

# assist: download video from clipboard link

instantinstall yt-dlp && \

{
LINK="$(/usr/share/instantassist/utils/y.sh)"
if [ -z "$LINK" ]; then
    echo "couldn't get link"
    notify-send -a instantASSIST "please copy a video link to clipboard"
    exit 1
fi

mkdir -p "$(xdg-user-dir VIDEOS)" &>/dev/null
cd "$(xdg-user-dir VIDEOS)" || exit 1
notify-send -a instantASSIST ' downloading video'
yt-dlp --playlist-items 1 "$LINK" || { notify-send -a instantASSIST " video download failed"; exit 1;}
notify-send -a instantASSIST " video downloaded ($(xdg-user-dir VIDEOS))"
}
