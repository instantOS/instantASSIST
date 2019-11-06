#!/bin/bash

BRIGHTNESS=$(printf "%d\n" {0..100..10} | dmenu -p 'brighness')
if [ -z "$BRIGHTNESS" ]; then
    exit
fi
xbacklight -set "$BRIGHTNESS1"
