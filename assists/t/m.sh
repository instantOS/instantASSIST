#!/bin/bash

# assist: toggle mouse off/on

if [ -e /tmp/zeromouse ]; then
    notify-send -a instantASSIST "mouse enabled"
else
    notify-send -a instantASSIST "mouse disabled"
fi

instantmouse z
