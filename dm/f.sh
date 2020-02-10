#!/usr/bin/env bash

# assist: choose a website to open in firefox

LINK=$(cat /opt/instantos/menus/data/firefox | instantmenu -n)
case "$LINK" in
s)
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
r)
    firefox reddit.com
    ;;
f)
    firefox
    ;;
esac
