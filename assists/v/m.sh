#!/usr/bin/env dash
# Script tested on several laptop built in mics and generic headsets/earbuds.
msgId="488219"
sources=$(pactl list sources)

micID=$(echo "$sources" |
        grep -B3 'Description: Built-in Audio Analog Stereo' |
        grep -m1 -Eo '[0-9]')
pactl set-source-mute "$micID" toggle || exit 0
micState=$(pactl list sources | sed -n "/Source #$micID/,/^$/p" |
           grep -E 'Mute: (yes|no)')

# Some browsers can record input through the monitor in my experience, or even Audacity if your in to that.
monitorID=$(echo "$sources" |
            grep -B3 'Description: Monitor of Built-in Audio Analog Stereo' |
            grep -m1 -Eo '[0-9]')
pactl set-source-mute "$monitorID" toggle

dunstify -a "toggleMicrophone" -u normal -r "$msgId" "Microphone $micState"
canberra-gtk-play -i dialog-information -d "toggleMicrophone"

