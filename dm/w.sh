#!/bin/bash

file="$HOME/paperbenni/wallpaper"
url='https://source.unsplash.com/random/1920x1080'
finalurl=$(curl "$url" -s -L -I -o /dev/null -w '%{url_effective}')
echo "final url = $finalurl"

dl_and_set(){
    if curl -s --create-dirs -o "$file.$1" "$finalurl"; then
        feh --bg-scale "$file.$1"
    fi
}

case "$finalurl" in
    *fm=jpg*)
        dl_and_set jpg ;;
    *fm=png*)
        dl_and_set png ;;
esac
