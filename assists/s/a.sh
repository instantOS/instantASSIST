#!/bin/bash

# assist: take screenshot and annotate it using flameshot
# TODO: configure flameshot for wayland

instantinstall flameshot && \
sleep 0.1 && \
flameshot gui
