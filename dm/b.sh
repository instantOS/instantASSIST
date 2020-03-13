#!/bin/bash

# assist: adjust display brightness

if [ -e /sys/class/backlight/ ] && [ "$(ls /sys/class/backlight | wc -l)" = "1" ]; then
	BGPU="/sys/class/backlight/$(ls /sys/class/backlight/)"
	MAXBRIGHT=$(cat "$BGPU/max_brightness")
	let "BRIGHTSTEP = $MAXBRIGHT / 20"
else
	echo "system doesn't support brightness changing or you ran into a bug here"
	exit 1
fi

brightness() {

	BRIGHTNESS="$(cat $BGPU/brightness)"
	case "$1" in
	-inc)
		let "bright = $BRIGHTNESS + $2"
		echo "$bright"
		if [ "$bright" -lt "$MAXBRIGHT" ] && [ "$bright" -gt 0 ]; then
			echo "$bright" >"$BGPU/brightness"
			echo "$bright"
		fi
		;;
	-dec)
		let "bright = $BRIGHTNESS - $2"
		if [ "$bright" -lt "$MAXBRIGHT" ] && [ "$bright" -gt 0 ]; then
			echo "$bright" >"$BGPU/brightness"
		fi
		;;

	-set)
		if [ "$2" -lt "$MAXBRIGHT" ] && [ "$2" -gt 0 ]; then
			echo "$2" >"$BGPU/brightness"
		fi
		;;

	*)
		return
		;;

	esac

}

# argument handling before instantmenu
if [ -n "$1" ]; then
	if ! grep -Eq '^(\+|-|[0-9])$' <<<"$1"; then
		exit
	fi

	let "BRIGHTSTEP = $BRIGHTSTEP / 4"
	case "$1" in

	"+")
		brightness -inc ${BRIGHTSTEP:-5}
		;;
	"-")

		brightness -dec ${BRIGHTSTEP:-5}
		;;
	*)
		brightness -set ${2:-50}
		;;

	esac
	exit
fi

while :; do
	CHOICE=$(echo '+
-
j
k
q' | instantmenu -n)

	if [ "$CHOICE" -eq "$CHOICE" ] &>/dev/null; then
		if [ "$CHOICE" = "0" ]; then
			# 0 doesnt work for some reason
			brightness -set 1
		else
			brightness -set "$CHOICE"
		fi
		break
	fi

	case "$CHOICE" in
	+)
		brightness -inc "${BRIGHTSTEP:-5}"
		;;
	-)
		brightness -dec "${BRIGHTSTEP:-5}"
		;;
	j)
		brightness -dec "${BRIGHTSTEP:-5}"
		;;
	k)
		brightness -inc "${BRIGHTSTEP:-5}"
		;;
	*)
		break
		;;
	esac

done
