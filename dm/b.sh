#!/usr/bin/dash

# assist: brightness slider

CURBRIGHT="$(/opt/instantos/menus/ex/b.sh g)"
MAXBRIGHT="$(/opt/instantos/menus/ex/b.sh m)"
islide -c "/opt/instantos/menus/ex/b.sh 2 " -s "$CURBRIGHT" -m "$MAXBRIGHT"
