#!/usr/bin/dash

# assist: toggle caffeine

# TODO: add x11 support

if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    kitty -e bash -c "systemd-inhibit --what=idle --who=Caffeine --why=Caffeine --mode=block sleep inf"
else
    notify-send -a instantASSIST 'X11 support WIP'
fi
