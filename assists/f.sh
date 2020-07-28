#!/usr/bin/dash

# assist: firefox

if ! [ -e ~/instantos/data/firefox ]; then
    echo "building firefox cache"
    mkdir -p ~/instantos/data
    cat /usr/share/instantassist/assists/f.sh | grep '^[a-z])' | grep -o '[a-z]' >~/instantos/data/firefox
fi

LINK=$(instantmenu -p "firefox" -n <~/instantos/data/firefox)

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
i)
    firefox instantos.github.io
    ;;
h)
    firefox github.com
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
    firefox "$(xclip -o)"
    ;;
t)
    firefox trello.com
    ;;
w)
    firefox --private-window
    ;;
f)
    firefox
    ;;
*)
    firefox
    ;;
esac
