#/usr/bin/dash

# assist: custom user assists

USERSCRIPTS="$HOME/.local/share/instantassist/"
CACHE="$HOME/.cache/instantassist/user_assists"

generate_cache () {
	for i in "$USERSCRIPTS"*'.sh'; do
		if [ -x "$i" ]; then
			echo "processing $i"
			SUBNAME="$(grep -o '[a-z]\.' <<<"$i" | grep -o '[a-z]')"
			echo "$SUBNAME$(grep '#'' assist: ' "$i" | sed 's/#'' assist: //')" >> "$CACHE"
		fi
	done
}

[ -d "$USERSCRIPTS" ] || exit
[ -e "$CACHE" ] || generate_cache

ASSIST="$(instantmenu -i -p instantASSIST -F -ct < "$CACHE" | grep -o '^.')"

[ -z "$ASSIST" ] && exit
SCRIPTPATH="${USERSCRIPTS}${ASSIST}.sh"
[ -x "$SCRIPTPATH" ] || exit

"$SCRIPTPATH" &
iconf lastassist "$SCRIPTPATH"
