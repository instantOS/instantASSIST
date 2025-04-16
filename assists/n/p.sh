#!/bin/bash

# assist: pick a color from the screen into the clipboard

if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    instantinstall hyprpicker && {
        hyprpicker | wl-copy
    }
else
    instantinstall colorpicker &&
        {
            DATA=$(colorpicker --one-shot --short | tr -d '\n')
            echo "$DATA" | xclip -selection clipboard

            SCDIR="/tmp/instantos/colorpicker/$(whoami)"
            mkdir -p "$SCDIR"
            PICNAME="$(date "+%s")".png

            # create picture with the color
            convert -size 45x45 "xc:$DATA" "$SCDIR/$PICNAME"

            notify-send "$DATA copied to clipboard" --icon="$SCDIR/$PICNAME"

            rm "$SCDIR/$PICNAME"
        }

fi
