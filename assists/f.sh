#!/usr/bin/env sh

# assist: web browser
LIST="$(cat /usr/share/instantassist/data/firefox)"
if [ -e ~/.config/instantos/instantassist/browser ]; then
    LIST="$LIST
$(cat ~/.config/instantos/instantassist/browser)"
fi

LINK="$(echo "$LIST" | instantmenu -ct | sed 's/^.//g')"

[ -z "$LINK" ] && exit

case "$LINK" in
clipboard)
    ~/.config/instantos/default/browser "$(xclip -o)"
    ;;
*firefox)
    firefox --private-window
    ;;
*tab)
    ~/.config/instantos/default/browser
    ;;
*)
    ~/.config/instantos/default/browser "$LINK"
    ;;
esac
