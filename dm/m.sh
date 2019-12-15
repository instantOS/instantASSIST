#!/bin/bash

LETTER="$(cat ~/paperbenni/menus/data/m | dmenu | grep -o '^.')"

xdotool type "$LETTER"
