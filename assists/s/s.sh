#!/usr/bin/env bash

# assist: screenshot a selected area into the picures folder

PICNAME="$(xdg-user-dir PICTURES)"/"$(date '+%Y%m%d%H%M%S')".png

if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    G=$(instantslop) || exit
    grim -g "$G" "$PICNAME"
else
    G=$(instantslop -f "%g") || exit 1
    import -window root -crop "$G" "$PICNAME"
fi

