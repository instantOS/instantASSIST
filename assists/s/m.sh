#!/usr/bin/env bash

# assist: take a fullscreen screenshot into clipboard

import -window root png:- | xclip -selection clipboard -t image/png &>/dev/null
