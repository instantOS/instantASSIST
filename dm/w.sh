#!/bin/bash

mkdir ~/paperbenni &>/dev/null

finalurl=$(curl 'https://source.unsplash.com/random/1920x1080' -s -L -I -o /dev/null -w '%{url_effective}')
echo "final url = $finalurl"

if echo "$finalurl" | grep 'jpg'; then
    wget -O ~/paperbenni/wallpaper.jpg "$finalurl"
    feh --bg-scale ~/paperbenni/wallpaper.jpg
else
    wget -O ~/paperbenni/wallpaper.png "$finalurl"
    feh --bg-scale ~/paperbenni/wallpaper.png
fi
