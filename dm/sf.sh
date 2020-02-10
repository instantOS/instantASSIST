#!/usr/bin/env bash

# assist: take a full screen screenshot
import -window root $(xdg-user-dir PICTURES)/$(date '+%Y%m%d%H%M%S').png
