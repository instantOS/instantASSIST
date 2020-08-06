#!/usr/bin/env bash
# assist: emoji picker

cd

# exit and remove leftover files
fail() {
    [ -e ~/.cache/emoji/list.txt ] && rm ~/.cache/emoji/list.txt
    if [ -n "$1" ]; then
        notify-send "error: $1"
    else
        notify-send 'emoji download failed'
    fi
    exit 1
}

# fetch list of emojis from unicode.org
if ! [ -e .cache/emoji/list.txt ]; then
    notify-send "downloading emoji list"
    mkdir -p .cache/emoji
    cd .cache/emoji

    if ! checkinternet && ! ping -c 1 google.com; then
        fail "no internet"
    fi

    if ! curl -s 'https://unicode.org/Public/emoji/13.0/emoji-test.txt' |
        grep 'E[0-9]' | grep '#' | grep -o '#.*' |
        sed 's/# \(.*\)E[0-9]*\.[0-9]* \(.*\)/\2 \1/g' >list.txt; then
        fail "unknown error"
    fi

    if ! [ "$(wc -l list.txt | grep -o '^[0-9]*')" -gt 1000 ]; then
        fail "list too short"
    fi

fi

# pick emojis using
cd

EMOJI="$(cat .cache/emoji/list.txt | instantmenu -b -l 20 -p 'emoji picker' | grep -o ' [^a-zA-Z0-9]*$' | grep -o '[^ ]*')"

if [ -z "$EMOJI" ]; then
    exit
fi

xdotool type "$EMOJI"
