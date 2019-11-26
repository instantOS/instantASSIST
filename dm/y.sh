#!/usr/bin/env bash

# download the clipboard link with youtube-dl

LINK="$(xclip -o -selection clipboard)"
mkdir -p $HOME/paperbenni/music &>/dev/null
cd $HOME/paperbenni/music
youtube-dl -x --audio-format mp3 "$LINK"
