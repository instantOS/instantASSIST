#!/usr/bin/env bash

# take a fullscreen screenshot into clipboard
import -window root png:- | xclip -selection clipboard -t image/png
