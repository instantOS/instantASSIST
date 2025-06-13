#!/usr/bin/dash

# assist: QR encode clipboard

# Get clipboard contents using same pattern as other assists
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    CLIPBOARD_CONTENT=$(wl-paste)
else
    CLIPBOARD_CONTENT=$(xclip -selection clipboard -o)
fi

# Check if clipboard has content
if [ -z "$CLIPBOARD_CONTENT" ]; then
    notify-send -a instantASSIST "Error: Clipboard is empty"
    exit 1
fi

# Check if qrencode is available
if ! command -v qrencode >/dev/null 2>&1; then
    notify-send -a instantASSIST "Error: qrencode not installed"
    exit 1
fi

# Create temporary script to avoid shell escaping issues
TEMP_SCRIPT=$(mktemp)
cat > "$TEMP_SCRIPT" << 'EOF'
#!/bin/bash
echo 'QR Code for clipboard contents:'
echo
printf '%s\n' "$1" | qrencode -t ansiutf8
echo
echo 'Press any key to close...'
read -n 1
EOF

chmod +x "$TEMP_SCRIPT"

# Generate QR code and display in terminal
kitty -e "$TEMP_SCRIPT" "$CLIPBOARD_CONTENT"

# Clean up
rm -f "$TEMP_SCRIPT"
