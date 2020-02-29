#!/usr/bin/env bash

# assist: choose a website to open in firefox

if ! [ -e ~/instantos/data/firefox ]; then
    echo "building firefox cache"
    mkdir -p ~/instantos/data
    cat /opt/instantos/menus/dm/f.sh | grep '^[a-z])' | grep -o '[a-z]' >~/instantos/data/firefox
fi

LINK=$(instantmenu -p "firefox" -n < ~/instantos/data/firefox)
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
c)
    firefox $(xclip -o)
    ;;
*)
    firefox
    ;;
esac
