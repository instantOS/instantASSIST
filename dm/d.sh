#!/bin/bash

# quickly swap monitors

MONITORS=$(xrandr | grep -Eo 'HDMI-[0-9]*')
# as of now only supports dual monitor setups
wc -l <<<"$MONITORS" | grep -q '2' || exit

MONITOR=$(dmenu -p 'choose left monitor' <<<"$MONITORS")
[ -n "$MONITOR" ] || exit

OTHERMONITOR=$(grep -v "$MONITOR" <<<"$MONITORS")

xrandr --output "$MONITOR" --left-of "$OTHERMONITOR"
echo xrandr --output "$MONITOR" --left-of "$OTHERMONITOR" > ~/paperbenni/monitor.sh