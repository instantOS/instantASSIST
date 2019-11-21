#!/bin/bash

# toggle compositor
if pgrep compton; then
    pkill compton
    exit
else
    if pgrep picom; then
        pkill picom
        exit
    else
        if command -v picom; then
            picom
        else
            compton
        fi
    fi
fi
