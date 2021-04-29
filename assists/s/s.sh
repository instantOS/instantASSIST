#!/usr/bin/env bash

# assist: screenshot a selected area into the picures folder

G=$(instantslop -f "%g") || exit 1

import -window root -crop "$G" "$(xdg-user-dir PICTURES)"/"$(date '+%Y%m%d%H%M%S')".png
