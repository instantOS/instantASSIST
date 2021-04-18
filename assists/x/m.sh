#!/bin/bash

# assist: manually set window opacity

instantinstall xorg-transset && \

{
OPACITY="$(imenu -i 'enter opacity (between 0 and 1)')"
[ -z "$OPACITY" ] && exit
if ! grep -q '^[0-9.]*$' <<<"$OPACITY"; then
    exit 1
fi

transset "$OPACITY"
}
