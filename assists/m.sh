#!/usr/bin/dash

# assist: play/pause music

if ! command -v spotify >/dev/null 2>&1; then
    playerctl play-pause
    exit 0
fi

if pgrep spotify >/dev/null 2>&1; then
    # pauses spotify player
    spoticli t
    exit
else
    if playerctl status || true | grep .; then
        playerctl play-pause
    else
        spoticli
    fi
fi
