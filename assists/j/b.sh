#!/bin/bash

# assist: play bruh sound

instantinstall mpv || exit 1

if ! [ -e ~/.cache/instantassist/bruh.m4a ]; then
    notify-send 'downloading bruh sound'
    mkdir -p ~/.cache/instantassist
    wget -O ~/.cache/instantassist/bruh.m4a 'http://bruhsound.surge.sh/bruh.m4a'
fi

[ -e ~/.cache/instantassist/bruh.m4a ] || exit 1

mpv ~/.cache/instantassist/bruh.m4a
