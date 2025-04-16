#!/usr/bin/env bash

# assist: scan a qr code to the clipboard

instantinstall zbar notify-send || exit 1
IMAGE_FILE="$(xdg-user-dir PICTURES)"/qrcode.png
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    instantinstall grim slurp || exit 1
    G=$(instantslop) || exit
    grim -g "$G" "$IMAGE_FILE"
else
    instantinstall xclip slop || exit 1
    G=$(instantslop -f "%g") || exit
    import -window root -crop "$G" "$IMAGE_FILE"
fi

DETECTEDTEXT="$(zbarimg -q "$IMAGE_FILE" | sed 's/^[^:]*://g')"

if [ -z "$DETECTEDTEXT" ]; then
    notify-send -a instantASSIST "no qr code detected"
    exit 1
fi

if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    wl-copy <<<"$DETECTEDTEXT"
else
    xclip -selection clip <<<"$DETECTEDTEXT"
fi

notify-send -a instantASSIST "Read QR code text
$DETECTEDTEXT"
