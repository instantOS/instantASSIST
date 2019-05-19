#!/usr/bin/env bash
LINK=$(cat ~/paperbenni/menus/data/firefox | dmenu)
case "$LINK" in
g)
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
    firefox dsbmobile.com
    ;;
    s)
  firefox google.com
  ;;
esac
