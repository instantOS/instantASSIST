#!/usr/bin/env bash

LINK="$(xclip -o)"
if ! echo "$LINK" | egrep 'youtube|soundcloud|vimeo'; then
    echo "not a video link"
    exit 1
fi

cd ~/paperbenni/music
echo "ytdl" > ~/.status
youtube-dl -x --audio-format mp3 "$LINK"
echo "|" > ~/.status
