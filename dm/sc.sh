#!/usr/bin/env bash

# assist: take a screenshot of a selected area into the clipboard

slop=$(slop -f "%g") || exit 1
import -window root -crop "$slop" png:- |
    xclip -selection clipboard -t image/png
