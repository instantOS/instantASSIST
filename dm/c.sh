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
        if command -v picom; then
            picom
        else
            compton
        fi
    fi
fi
