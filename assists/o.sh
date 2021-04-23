#!/bin/bash
# assist: open file in text editor

CHOICE="$(instantfilepick)" || exit

instantutils open editor "$CHOICE"
