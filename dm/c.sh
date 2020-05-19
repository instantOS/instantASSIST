#!/bin/bash

# assist: toggle compositor

if pgrep compton; then
    pkill compton
    exit
else
    if pgrep picom; then
        notify-send '[instantASSIST] compositing disabled'
        pkill picom
        exit
    else
        notify-send '[instantASSIST] compositing enabled'
        if command -v picom &>/dev/null; then
            if iconf -i blur; then
                picom --experimental-backends &
            else
                picom &
            fi
        else
            compton
        fi
    fi
fi
