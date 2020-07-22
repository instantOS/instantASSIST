#!/usr/bin/env bash

# assist: play/pause music

if ! command -v spotify &>/dev/null; then
    notify-send '[instantASSIST] please install spotify first'
    exit 0
else
    playerctl play-pause
    exit
fi

if pgrep spotify &>/dev/null; then
    # pauses spotify player
    dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause
    exit
else
    if ! playerctl status || true | grep .; then
        playerctl play-pause
    else
        LD_PRELOAD="/usr/share/instantassist/spotify-adblock.so" spotify
    fi
fi
