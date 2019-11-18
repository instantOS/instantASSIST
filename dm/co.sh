#!/bin/bash

if grep -iq 'ubuntu' </etc/os-release; then
    if pgrep compton; then
        pkill compton
    else
        compton &
    fi
fi

if grep -iq 'arch' </etc/os-release; then
    if pgrep picom; then
        pkill picom
    else
        picom &
    fi
fi
