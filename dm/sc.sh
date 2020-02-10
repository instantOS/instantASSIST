#!/usr/bin/env bash

# assist: take a screenshot of a selected area

slop=$(slop -f "%g") || exit 1
read -r G < <(echo $slop)
import -window root -crop $G png:- | \
xclip -selection clipboard -t image/png
