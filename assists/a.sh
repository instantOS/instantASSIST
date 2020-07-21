#!/usr/bin/dash

# assist: audio volume slider

CURVOL="$(amixer get Master | grep -Eo '[0-9]{1,3}%' | head -1 | grep -o '[0-9]*')"
islide -s "$CURVOL" -c "/usr/share/instantassist/menus/ex/p.sh "
