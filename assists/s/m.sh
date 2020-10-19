#!/usr/bin/env bash

# assist: take a fullscreen screenshot into clipboard

pgrep picom && sleep 0.5
import -window root png:- | xclip -selection clipboard -t image/png
