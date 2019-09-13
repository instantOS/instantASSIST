#!/bin/bash

huid=$(xinput | grep -i pen | egrep -o '[a-zA-Z0-9].*id=[0-9]*' | dmenu -l 10 | egrep -o 'id=[0-9]*' | egrep -o '[0-9]*')
echo $huid
xrid=$(xrandr | egrep -o 'HDMI-[0-9]*' | dmenu -l 10)
xinput map-to-output $huid $xrid
