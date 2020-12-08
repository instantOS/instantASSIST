#!/usr/bin/dash

# assist: toggle compositing

if pgrep picom; then
    notify-send -a instantASSIST ' compositing disabled'
    pkill picom
    exit
else
    notify-send -a instantASSIST ' compositing enabled'
    ipicom
fi
