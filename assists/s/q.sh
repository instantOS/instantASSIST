#!/usr/bin/env bash

# assist: scan a qr code to the clipboard

instantinstall zbarimg notify-send xclip || exit 1

IMAGE_FILE="$(xdg-user-dir PICTURES)"/qrcode.png

G=$(instantslop -f "%g") || exit 1
import -window root -crop "$G" "$IMAGE_FILE" || exit 1

DETECTEDTEXT="$(zbarimg -q "$IMAGE_FILE" | sed 's/^[^:]*://g')"

if [ -z "$DETECTEDTEXT" ]; then
    notify-send -a instantASSIST "no qr code detected"
    exit 1
fi

xclip -selection clip <<<"$DETECTEDTEXT"
notify-send -a instantASSIST "Read QR code text
$DETECTEDTEXT"
