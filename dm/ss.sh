#!/usr/bin/env bash

# assist: screenshot a selected area into the picures folder

slop=$(slop -f "%g") || exit 1
read -r G < <(echo "$slop")
import -window root -crop "$G" $(xdg-user-dir PICTURES)/$(date '+%Y%m%d%H%M%S').png
