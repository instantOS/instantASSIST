#!/bin/bash

# assist: set mouse sensitivity

CURRENTSPEED="$(iconf mousespeed)"
PRESPEED=$(echo "($CURRENTSPEED + 1) * 50" | bc -l | grep -o '^[^.]*')
islide -s "$PRESPEED" -c "instantmouse m " -p "mouse sensitivity"
iconf mousespeed "$(instantmouse l)"
