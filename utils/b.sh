#!/bin/bash

# assist: adjust display brightness

if [ -e /sys/class/backlight/ ] && [ "$(ls /sys/class/backlight | wc -l)" = "1" ]; then
	BGPU="/sys/class/backlight/$(ls /sys/class/backlight/)"
	MAXBRIGHT=$(cat "$BGPU/max_brightness")
	let "BRIGHTSTEP = $MAXBRIGHT / 20"
else
	notify-send '[instantASSIST] setting brightness is not supported on this device'
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
	if ! grep -Eq '^(\+|-|[0-9]|g|m)$' <<<"$1"; then
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
	g)
		cat "$BGPU/brightness"
		;;
	m)
		echo "$MAXBRIGHT"
		;;
	*)
		brightness -set ${2:-50}
		;;

	esac
	exit
fi
