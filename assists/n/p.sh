#!/bin/bash

# assist: pick a color from the screen into the clipboard

instantinstall colorpicker && \
colorpicker --one-shot --short | tr -d '\n' | xclip -selection clipboard
