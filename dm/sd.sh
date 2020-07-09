#!/usr/bin/env bash

# assist: wait 5 seconds and take a full screen screenshot to your pictures folder
sleep 5
import -window root $(xdg-user-dir PICTURES)/$(date '+%Y%m%d%H%M%S').png
