#!/usr/bin/env bash

# assist: play/pause music

if ! command -v spotify &>/dev/null; then
    playerctl play-pause
    exit 0
fi

if pgrep spotify &>/dev/null; then
    # pauses spotify player
    dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause
    exit
else
    if playerctl status || true | grep .; then
        playerctl play-pause
    else
        LD_PRELOAD="/usr/share/instantassist/spotify-adblock.so" spotify
    fi
fi
