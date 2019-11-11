#!/bin/bash

url='https://source.unsplash.com/random/1920x1080'
finalurl=$(curl "$url" -s -L -I -o /dev/null -w '%{url_effective}')
echo "final url = $finalurl"

dl_and_set(){
    curl -s --create-dirs -o - "$finalurl" | feh --bg-scale -
}

case "$finalurl" in
    *fm=jpg*)
        dl_and_set jpg ;;
    *fm=png*)
        dl_and_set png ;;
esac
