#!/usr/bin/env bash

# download the clipboard link with youtube-dl

LINK="$(xclip -o -selection clipboard)"
if ! [[ "$LINK" =~ (youtube|soundcloud|vimeo) ]]; then
    echo "not a supported video link" >&2
    exit 1
fi

mkdir -p $HOME/paperbenni/music &>/dev/null
cd $HOME/paperbenni/music
echo "ytdl" >~/.status
youtube-dl -x --audio-format mp3 "$LINK"
echo "|" >~/.status
