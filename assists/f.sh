#!/usr/bin/dash

# assist: web browser

LINK="$(instantmenu -ct </usr/share/instantassist/data/firefox)"

[ -z "$LINK" ] && exit

case "$LINK" in
clipboard)
    firefox "$(xclip -o)"
    ;;
*firefox)
    firefox --private-window
    ;;
*tab)
    firefox
    ;;
*)
    firefox "$LINK"
    ;;
esac
