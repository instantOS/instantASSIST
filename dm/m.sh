#!/usr/bin/env bash

# assist: open spotify or toggle pause/play if it's already open

command -v spotify &>/dev/null || exit 0

if pgrep spotify &>/dev/null; then
    # pauses spotify player
    dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause
    exit
else
    LD_PRELOAD="/opt/instantos/spotify-adblock.so" spotify
fi
