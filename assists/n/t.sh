#!/usr/bin/dash

# assist: rename current tag

NEWNAME="$(imenu -i 'rename tag (15 char max length)')"
[ -z "$NEWNAME" ] && exit
[ ${#NEWNAME} -gt 15 ] && /usr/share/instantassist/assists/n/t.sh && exit
instantwmctl nametag "$NEWNAME"

