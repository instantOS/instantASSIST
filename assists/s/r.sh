#!/usr/bin/env bash

# assist: detect text from selected area

# inspired by https://old.reddit.com/r/commandline/comments/oceuu3/nifty_little_ocr_script_which_i_use_a_lot_maybe/

set -e

instantinstall tesseract tesseract-data-eng \
    notify-send xclip slop grim slurp wl-clipboard || exit 1

IMAGE_FILE="$(xdg-user-dir PICTURES)"/ocr.png

if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    G=$(instantslop)
    echo "G: $G"
    grim -g "$G" "$IMAGE_FILE"
    CLIPBOARD_CMD="wl-copy"
else
    G=$(instantslop -f "%g") || exit 1
    import -window root -crop "$G" "$IMAGE_FILE" || exit 1
    CLIPBOARD_CMD="xclip -selection clip"
fi

# TODO: document what the sed command is for
DETECTEDTEXT="$(tesseract "$IMAGE_FILE" stdout | sed 's/\x0c//')"

if [ -z "$DETECTEDTEXT" ]; then
    notify-send -a instantASSIST "no text detected"
    exit 1
fi

if ! $CLIPBOARD_CMD <<<"$DETECTEDTEXT"; then
     echo "Error: Failed to copy text to clipboard using $CLIPBOARD_CMD." >&2
     notify-send -a instantASSIST -u critical "OCR Error" "Failed to copy text to clipboard."
fi

notify-send -a instantASSIST "Detected text" "$DETECTEDTEXT"
