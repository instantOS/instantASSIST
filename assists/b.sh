#!/usr/bin/dash

# assist: brightness slider

CURBRIGHT="$(/usr/share/instantassist/utils/b.sh g)"

if [ -z "$CURBRIGHT" ]; then
    notify-send "brightness not supported on this device"
    exit
fi

MAXBRIGHT="$(/usr/share/instantassist/utils/b.sh m)"
islide -c "/usr/share/instantassist/utils/b.sh 2 " -s "$CURBRIGHT" -m "$MAXBRIGHT"
CURBRIGHT="$(/usr/share/instantassist/utils/b.sh g)"
iconf savebright "$CURBRIGHT"
