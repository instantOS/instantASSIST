#!/bin/bash

source <(curl -Ls https://git.io/JerLG)

TEXT="$(echo test | dmenu -p 'spam text')"
zerocheck "$TEXT"

LOOP="$(echo 10 | dmenu -p 'spam count')"
zerocheck "$LOOP"
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
