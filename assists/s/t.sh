#!/usr/bin/env bash

# assist: screenshot a selected area after 5 seconds

G=$(instantslop -f "%g") || exit 1
sleep 5
import -window root -crop "$G" "$(xdg-user-dir PICTURES)/$(date '+%Y%m%d%H%M%S')".png
