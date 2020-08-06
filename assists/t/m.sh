#!/usr/bin/env bash

# assist: toggle mouse off/on

if [ -e /tmp/zeromouse ]; then
    notify-send "mouse enabled"
else
    notify-send "mouse disabled"
fi

instantmouse z
