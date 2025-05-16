#!/bin/bash

# assist: take screenshot and annotate it using flameshot
# TODO: configure flameshot for wayland

instantinstall flameshot
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    export SDL_VIDEODRIVER=wayland
    export _JAVA_AWT_WM_NONREPARENTING=1
    export QT_QPA_PLATFORM=wayland
    export XDG_CURRENT_DESKTOP=sway
    export XDG_SESSION_DESKTOP=sway
    if ! pgrep flameshot > /dev/null; then
        flameshot &
        sleep 2
    fi
    flameshot gui
else
    # TODO: why is the sleep needed?
    sleep 0.1
    flameshot gui
fi
