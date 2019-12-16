#!/usr/bin/env bash

# m = music
# opens spotify with adblock

command -v spotify &>/dev/null || exit 0

if pgrep spotify &>/dev/null; then
    [ -e /tmp/spotifyid ] || exit
    grep -q '{3,}*' </tmp/spotifyid || exit
    if wmctrl -l | grep -iq "$(cat /tmp/spotifyid)"; then
        dswitch "$(cat /tmp/spotifyid)"
    fi
else

    [ -e ~/.cache/spotblock ] || mkdir -p ~/.cache/spotblock
    cd ~/.cache/spotblock

    if ! [ -e spotify-adblock.so ]; then
        git clone --depth=1 https://github.com/abba23/spotify-adblock-linux.git .
        make || wget "http://spotifyadblock.surge.sh/spotify-adblock.so"
    fi

    LD_PRELOAD=./spotify-adblock.so spotify &
    sleep 1
    for i in {1..5}; do
        if wmctrl -l | grep -qi "spotify"; then
            wmctrl -l | grep -i "spotify" | head -1 | grep -o '^[^ ]*' >/tmp/spotifyid
        fi
        sleep 2
    done

fi
