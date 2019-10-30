#!/bin/bash

mkdir ~/paperbenni &>/dev/null
wget -O ~/paperbenni/wallpaper.png 'https://source.unsplash.com/random/1920x1080'
feh --bg-scale ~/paperbenni/wallpaper.jpg
