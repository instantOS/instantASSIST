#!/usr/bin/env bash

# assist: take a full screen screenshot to the pictures folder

pgrep picom && sleep 0.5
sleep 0.1
import -window root "$(xdg-user-dir PICTURES)/$(date '+%Y%m%d%H%M%S')".png
