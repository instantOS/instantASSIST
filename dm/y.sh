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
        return 0
    else
        echo "no clipboardable link found"
        return 1
    fi
}

# empty clipboard?
if ! grep -q '.....' <<<"$LINK"; then
    newlink
fi

# only download first video of playlist
if grep -q 'music\.youtube\.com/watch?v=.*&list=.*' <<<"$LINK"; then
    LINK2=$LINK
    LINK=$(grep -o '.*music\.youtube\.com/watch?v=[^&]*' <<<"$LINK")
fi

# already downloaded?
if [ -e ~/.cache/instantos/youtube.txt ]; then
    OLDLINK="$(cat ~/.cache/instantos/youtube.txt)"
    if [ "$LINK" = "$OLDLINK" ]; then
        echo "already downloaded"
        newlink || exit
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
youtube-dl --playlist-items 1 -x --audio-format mp3 "$LINK" || exit
echo "$LINK" >~/.cache/instantos/youtube.txt
