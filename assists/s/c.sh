#!/usr/bin/env bash

# assist: take a screenshot of a selected area into the clipboard

if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    slop=$(instantslop) || exit
    grim -g "$slop" - | wl-copy
else
    slop=$(instantslop -f "%g") || exit
    import -window root -crop "$slop" png:- |
        xclip -selection clipboard -t image/png &>/dev/null
fi
