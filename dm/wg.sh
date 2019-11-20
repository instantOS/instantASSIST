#!/bin/bash

#######################################
## chromecast like wallpaper changer ##
#######################################

randomwallpaper() {
    file="$HOME/paperbenni/wallpaper.jpg"
    if curl google.com; then
        url='https://storage.googleapis.com/chromeos-wallpaper-public'

        fetch() {
            IFS='<' read -a array <<<"$(wget -O - -q "$url")"
            for field in "${array[@]}"; do
                if [[ "$field" == *_resolution.jpg ]]; then
                    IFS='>' read -a key <<<"$field"
                    printf "%s\n" "${key[1]}"
                fi
            done
        }

        wget -qO "$file" "$url/$(fetch | shuf -n 1)"
    fi
    feh --bg-scale "$file"
}

randomwallpaper
