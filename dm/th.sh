#!/bin/bash

# assist: map your huion graphics tablet to only one monitor. 

huid=$(xinput | grep -i pen | grep -Eo '[a-zA-Z0-9].*id=[0-9]*' | instantmenu -l 10 | grep -Eo 'id=[0-9]*' | grep -Eo '[0-9]*')
if [ -z "$huid" ]; then
    echo "no input device selected"
    exit
fi

echo "$huid"

xrid=$(xrandr | grep -Eo 'HDMI-[0-9]*' | instantmenu -l 10)
if [ -z "$xrid" ]; then
    echo "no monitor selected"
    exit
fi

xinput map-to-output "$huid" "$xrid"
