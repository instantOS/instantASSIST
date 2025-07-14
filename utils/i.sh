#!/bin/bash

# Open clipboard contents in ChatGPT, url-encoded, using browser

if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    CLIPBOARD_CONTENT="$(wl-paste 2>/dev/null)"
else
    CLIPBOARD_CONTENT="$(xclip -selection clipboard -o 2>/dev/null)"
fi

if [ -z "$CLIPBOARD_CONTENT" ]; then
    notify-send -a instantASSIST "Error: Clipboard is empty"
    exit 1
fi

ENCODED="$(printf '%s' "$CLIPBOARD_CONTENT" | jq -s -R -r @uri)"
CHATGPT_URL="https://chat.openai.com/?prompt=$ENCODED"

if command -v instantutils >/dev/null 2>&1; then
    instantutils open browser "$CHATGPT_URL"
else
    xdg-open "$CHATGPT_URL"
fi
