#!/usr/bin/dash

# assist: brightness slider

CURBRIGHT="$(/usr/share/instantassist/menus/ex/b.sh g)"
MAXBRIGHT="$(/usr/share/instantassist/menus/ex/b.sh m)"
islide -c "/usr/share/instantassist/menus/ex/b.sh 2 " -s "$CURBRIGHT" -m "$MAXBRIGHT"
