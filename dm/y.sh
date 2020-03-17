#!/usr/bin/env bash

# assist: download clipboard link with youtube-dl

LINK="$(xclip -o -selection clipboard)"

# attempts to get a new link by copying it out of firefox
newlink() {
    if xdotool getactivewindow getwindowname | grep -iq 'mozilla firefox'; then
        xdotool key Ctrl+l
        sleep 0.1
        xdotool key Ctrl+c
        export LINK="$(xclip -o -selection clipboard)"
    else
        echo "no clipboardable link found"
        exit
    fi
}

# link not valid?
LINKLINES=$(wc -l <<<"$LINK")
if grep -q '.....' <<<"$LINK" && {
    [ "$LINKLINES" = "0" ] || [ "$LINKLINES" = "1" ]
}; then
    echo "link appears to be valid"
else
    echo "link invalid, attemptiing to get new link"
    newlink
fi

cleanlink() {
    # only download first video of playlist
    if grep -q 'music\.youtube\.com/watch?v=.*&list=.*' <<<"$LINK"; then
        LINK2="$LINK"
        LINK=$(grep -o '.*music\.youtube\.com/watch?v=[^&]*' <<<"$LINK")
    fi
}

cleanlink

# already downloaded?
if [ -e ~/.cache/instantos/youtube.txt ]; then
    OLDLINK="$(cat ~/.cache/instantos/youtube.txt)"
    if [ "$LINK" = "$OLDLINK" ]; then
        echo "already downloaded"
        newlink
        cleanlink
        if [ "$LINK" = "$OLDLINK" ]; then
            echo "still on the same webpage"
            exit
        fi
    fi
else
    mkdir -p ~/.cache/instantos
fi

mkdir -p $(xdg-user-dir MUSIC) &>/dev/null
cd $(xdg-user-dir MUSIC)
notify-send '[instantASSIST] downloading mp3'
youtube-dl --playlist-items 1 -x --audio-format mp3 "$LINK" || exit
echo "$LINK" >~/.cache/instantos/youtube.txt
