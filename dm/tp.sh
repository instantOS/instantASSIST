#!/bin/sh

# assist: run this if your pulseaudio hotkeys stop working

pkill pulseaudio
sleep 0.5
pulseaudio --start
notify-send '[instantASSIST] pulseaudio has been restarted'
