#!/bin/bash

# assist: repeat a given text n times

TEXT="$(echo test | instantmenu -p 'spam text')"
[ -n "$TEXT" ] || exit

LOOP="$(echo 10 | instantmenu -p 'repeat')"
[ -n "$LOOP" ] || exit

if ! [ "$LOOP" -eq "$LOOP" ]; then
    LOOP=10
fi

sleep 4
echo "$LOOP"

x=$LOOP
while [ $x -gt 0 ]; do
    xdotool type "$TEXT"
    sleep 0.05
    xdotool key KP_Enter
    x=$(($x - 1))
done
