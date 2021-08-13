#!/usr/bin/env bash

# assist: detect text from selected area

# inspired by https://old.reddit.com/r/commandline/comments/oceuu3/nifty_little_ocr_script_which_i_use_a_lot_maybe/

instantinstall tesseract tesseract-data-eng notify-send xclip || exit 1

IMAGE_FILE="$(xdg-user-dir PICTURES)"/ocr.png
G=$(instantslop -f "%g") || exit 1
import -window root -crop "$G" "$IMAGE_FILE" || exit 1

DETECTEDTEXT="$(tesseract "$IMAGE_FILE" stdout | sed 's/\x0c//')"

if [ -z "$DETECTEDTEXT" ]; then
    notify-send -a instantASSIST "no text detected"
    exit 1
fi

xclip -selection clip <<<"$DETECTEDTEXT"
notify-send -a instantASSIST "Detected text
$DETECTEDTEXT"
