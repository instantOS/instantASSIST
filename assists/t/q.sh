#!/usr/bin/env bash

# assist: swap monitors

MONITORS=$(xrandr | grep ' connected' | grep -o '^[^ ]*')
# as of now only supports dual monitor setups
wc -l <<<"$MONITORS" | grep -q '2' || exit

MONITOR=$(instantmenu -p 'choose left monitor' <<<"$MONITORS")
[ -n "$MONITOR" ] || exit

OTHERMONITOR=$(grep -v "$MONITOR" <<<"$MONITORS")

xrandr --output "$MONITOR" --left-of "$OTHERMONITOR"
echo xrandr --output "$MONITOR" --left-of "$OTHERMONITOR" >~/instantos/monitor.sh
