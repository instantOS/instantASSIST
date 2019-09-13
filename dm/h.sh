#!/bin/bash

huid=$(xinput | grep -i pen | egrep -o '[a-zA-Z0-9].*id=[0-9]*' | dmenu -l 10 | egrep -o 'id=[0-9]*' | egrep -o '[0-9]*')
if [ -z "$huid" ]; then
    echo "no input device selected"
    exit
fi

echo $huid

xrid=$(xrandr | egrep -o 'HDMI-[0-9]*' | dmenu -l 10)
if [ -z "$xrid" ]; then
    echo "no monitor selected"
    exit
fi

xinput map-to-output $huid $xrid
