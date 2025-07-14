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

LLM_URL=""

if [ -z "$1" ]; then
    LLM_URL="https://chat.openai.com/?prompt"
else
    case "$1" in
    google | gemini | g)
        LLM_URL="https://gemini.google.com/?q"
        ;;
    openai | chatgpt | o)
        LLM_URL="https://chat.openai.com/?prompt"
        ;;
    claude | anthropic | c)
        LLM_URL="https://claude.ai/new?q"
        ;;
    *)
        LLM_URL="https://chat.openai.com/?prompt"
        ;;
        # Coral, Kimi, DeepSeek etc. do not support this (yet)
        # If they do at some point, please notify me ;)
    esac
fi

MESSAGE_URL="$LLM_URL=$ENCODED"

if command -v instantutils >/dev/null 2>&1; then
    instantutils open browser "$MESSAGE_URL"
else
    xdg-open "$LLM_URL"
fi

if [ "$XDG_SESSION_TYPE" = "wayland" ] &&
    command -v swaymsg >/dev/null &&
    [ -n "$SWAYSOCK" ]; then
    # TODO: come up with something better than waiting a fixed amount of time
    sleep 4
    swaymsg '[urgent=latest] focus'
fi
