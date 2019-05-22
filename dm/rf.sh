#!/usr/bin/env bash

screencast() { \
	ffmpeg -y \
	-f x11grab \
	-framerate 60 \
	-s $(xdpyinfo | grep dimensions | awk '{print $2;}') \
	-i :0.0 \
	-f alsa -i default \
	-r 30 \
 	-c:v libx264rgb -crf 0 -preset ultrafast -c:a flac \
	"$HOME/paperbenni/recordings/screencast-$(date '+%y%m%d-%H%M-%S').mkv" &
	echo $! > /tmp/recordingpid
}

killrecording() {
	recpid="$(cat /tmp/recordingpid)"
	# kill with SIGTERM, allowing finishing touches.
	kill -15 "$recpid"
	rm -f /tmp/recordingpid
	# even after SIGTERM, ffmpeg may still run, so SIGKILL it.
	sleep 3
	kill -9 "$recpid"
	exit
}
