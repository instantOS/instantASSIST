#!/bin/bash

BRIGHTNESS=$(seq 0 10 100 | dmenu -p 'brighness')
if [ -z "$BRIGHTNESS" ]; then
    exit
fi
xbacklight -set "$BRIGHTNESS1"
