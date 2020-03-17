#!/bin/bash

# assist: invert screen colors

command -v xcalib || exit 1

if [ -e /tmp/.xinvert ]; then
    xcalib -c
    rm /tmp/.xinvert
else
    xcalib -i -a
    touch /tmp/.xinvert
fi
