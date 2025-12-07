#!/usr/bin/env bash

# assist: "freeze" part of the screen

SCDIR="$(mktemp -d)"
PICNAME="$(date "+%s")".png

if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    G=$(instantslop) || exit 1
    grim -g "$G" "$SCDIR/$PICNAME"
else
    G=$(instantslop -f "%g") || exit 1
    import -window root -crop "$G" "$SCDIR/$PICNAME"
fi

# make feh floating
if [ "$XDG_SESSION_TYPE" = "wayland" ] && command -v swaymsg >/dev/null && [ -n "$SWAYSOCK" ]; then
    # Parse geometry: G="X,Y WIDTHxHEIGHT"
    X=$(echo "$G" | awk -F'[ ,x]' '{print $1}')
    Y=$(echo "$G" | awk -F'[ ,x]' '{print $2}')
    W=$(echo "$G" | awk -F'[ ,x]' '{print $3}')
    H=$(echo "$G" | awk -F'[ ,x]' '{print $4}')
    feh --title "instantASSIST screen freeze" --geometry "$G" "$SCDIR/$PICNAME" &
    FEH_PID=$!
    # Wait for feh to appear in the tree
    for i in {1..20}; do
        sleep 0.1
        swaymsg '[title="instantASSIST screen freeze"]' floating enable && \
        swaymsg "[title=\"instantASSIST screen freeze\"]" move position "$X" "$Y" && \
        swaymsg "[title=\"instantASSIST screen freeze\"]" resize set "$W" px "$H" px && break
    done
else
    instantwmctl specialnext 1
    feh --title "instantASSIST screen freeze" --geometry "$G" "$SCDIR/$PICNAME" &
fi

sleep 5
rm -rf "$SCDIR"
