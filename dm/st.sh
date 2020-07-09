#!/usr/bin/env bash

# assist: screenshot a selected area after 5 seconds

slop=$(slop -f "%g") || exit 1
read -r G < <(echo "$slop")
sleep 5
import -window root -crop "$G" $(xdg-user-dir PICTURES)/$(date '+%Y%m%d%H%M%S').png
