#!/bin/sh
# run this if your pulseaudio hotkeys stop working

pkill pulseaudio
sleep 0.5
pulseaudio --start
