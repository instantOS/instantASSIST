#!/usr/bin/env bash

# assist: spotifyctl

command -v spotify &>/dev/null || {
    notify-send '[instantASSIST] please install spotify first'
    exit 0
}

if pgrep spotify &>/dev/null; then
    # pauses spotify player
    dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause
    exit
else
    LD_PRELOAD="/usr/share/instantassist/spotify-adblock.so" spotify
fi
