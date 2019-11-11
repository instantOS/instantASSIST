#!/bin/bash

#######################################
## chromecast like wallpaper changer ##
#######################################

randomwallpaper() {
    WALLPAPERNAME="$(curl 'https://storage.googleapis.com/chromeos-wallpaper-public/' |
        grep -Eo '<Key>[^<>]*</Key>' | grep 'resolution.*\.jpg' |
        grep -o '>.*<' | grep -o '[^<>]*' |
        shuf | head -1)"
    grep -q 'resolution' <<<$WALLPAPERNAME || return 1
    wget -O ~/paperbenni/wallpaper.jpg "https://storage.googleapis.com/chromeos-wallpaper-public/$WALLPAPERNAME"
    feh --bg-scale ~/paperbenni/wallpaper.jpg

}
