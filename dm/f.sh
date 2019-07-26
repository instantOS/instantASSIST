#!/usr/bin/env bash

# dmenu to choose a website to open in firefox

LINK=$(cat ~/paperbenni/menus/data/firefox | dmenu)
case "$LINK" in
gh)
    firefox github.com
    ;;
y)
    firefox youtube.com
    ;;
p)
    firefox paperbenni.github.io
    ;;
h)
    firefox heroku.com
    ;;
d)
    firefox dsbmobile.de
    ;;
g)
    firefox google.com
    ;;
esac
