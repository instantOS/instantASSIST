#!/usr/bin/env bash

# assist: take a screenshot and upload it to file.coffee

G=$(slop -f "%g") || exit 1
SCROTNAME="$(date '+%Y%m%d%H%M%S')"
PICTUREDIR="$(xdg-user-dir PICTURES)"
import -window root -crop "$G" $PICTUREDIR/$SCROTNAME.png
notify-send '[instantASSIST] uploading screenshot'

filecoffee() {
    if iconf coffeetoken; then
        curl --location --request POST "https://file.coffee/api/v1/upload?key=$(iconf coffeetoken)" \
            --form "file=@$1" | grep -o '"https://.*"' | grep -o '[^"]*' | grep -o 'https://.*'
    else
        curl --location --request POST 'https://file.coffee/api/v1/upload' \
            --form "file=@$1" | grep -o '"https://.*"' | grep -o '[^"]*'
    fi
}

if ping -c 1 archlinux.org; then
    IMGURLINK="$(filecoffee $PICTUREDIR/$SCROTNAME.png | grep -o 'https://.*')"
    notify-send "copied filecoffee link: $IMGURLINK"
    echo "$IMGURLINK" | xclip -selection c
    echo "$IMGURLINK" >>~/screenshots
else
    notify-send 'upload failed'
fi
