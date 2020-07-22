#!/bin/sh

# assist: restart pulseaudio

pkill pulseaudio
sleep 0.5
pulseaudio --start &
notify-send '[instantASSIST] pulseaudio has been restarted'
