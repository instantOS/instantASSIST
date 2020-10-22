#!/bin/bash

# assist: manually set window opacity

if ! command -v transset; then
    instantinstall xorg-transset
fi

OPACITY="$(imenu -i 'enter opacity (between 0 and 1)')"
[ -z "$OPACITY" ] && exit
if ! grep -q '^[0-9.]*$' <<<"$OPACITY"; then
    exit 1
fi

transset "$OPACITY"
