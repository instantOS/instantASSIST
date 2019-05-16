#!/usr/bin/env bash
slop=$(slop -f "%g") || exit 1
read -r G < <(echo $slop)
import -window root -crop $G ~/paperbenni/screenshots/$(date '+%Y%m%d%H%M%S').png
