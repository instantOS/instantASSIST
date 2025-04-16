#!/usr/bin/dash

# assist: toggle compositing

if [ -z "$XDG_SESSION_TYPE" = "wayland" ]; then
    notify-send -a instantASSIST ' you on wayland you doofus'
    exit
fi

if pgrep picom; then
    notify-send -a instantASSIST ' compositing disabled'
    pkill picom
    exit
else
    notify-send -a instantASSIST ' compositing enabled'
    ipicom
fi
