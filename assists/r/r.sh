#!/bin/bash

# assist: set up screen recordings with ffmpeg, allowing you to choose an area

source /usr/share/instantassist/utils/r.sh

checkrecording

slop=$(slop -f "%x %y %w %h %g %i") || exit 1
read -r X Y W H G ID < <(echo "$slop")

areascreencast
