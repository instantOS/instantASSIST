#!/bin/bash

# assist: tweak xorg for vim

if ! iconf -i xorgvim
then
    iconf -i xorgvim 1
    xset r rate 200 100
    setxkbmap -option caps:escape
    notify-send '[instantASSIST] xorg vim tweaks enabled'
else
    iconf -i xorgvim 0
    xset r rate
    setxkbmap -option
    notify-send '[instantASSIST] xorg vim tweaks disabled'
fi


