#!/usr/bin/env bash

# m = music
# opens spotify with adblock

command -v spotify &>/dev/null || exit 0

if pgrep spotify &>/dev/null; then
    # pauses spotify player
    dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause
    exit
else
    [ -e ~/.cache/spotblock ] || mkdir -p ~/.cache/spotblock
    cd ~/.cache/spotblock

    if ! [ -e spotify-adblock.so ]; then
        git clone --depth=1 https://github.com/abba23/spotify-adblock-linux.git .
        make || wget "http://spotifyadblock.surge.sh/spotify-adblock.so"
    fi

    LD_PRELOAD=./spotify-adblock.so spotify
fi
