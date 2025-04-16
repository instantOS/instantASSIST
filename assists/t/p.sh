#!/bin/sh

# assist: restart audio

if pgrep pulseaudio || command -v pulseaudio; then
    pkill pulseaudio
    sleep 0.5
    pulseaudio --start &
    notify-send -a instantASSIST ' pulseaudio has been restarted'
else
    systemctl --user restart pipewire pipewire-pulse wireplumber
    notify-send -a instantASSIST ' pipewire has been restarted'
fi

