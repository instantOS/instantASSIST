#!/usr/bin/env bash

# full screen screenshot
import -window root $(xdg-user-dir PICTURES)/$(date '+%Y%m%d%H%M%S').png
