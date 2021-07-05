#!/bin/bash

# assist: set wallpaper from styli.sh

instantinstall git nitrogen || exit 1

if ! [ -e ~/.cache/instantassist/styli.sh/styli.sh ]; then
    notify-send -a instantASSIST 'downloading styli.sh'
    mkdir -p ~/.cache/instantassist
    cd ~/.cache/instantassist || exit 1
    git clone --depth=1 https://github.com/thevinter/styli.sh.git
fi

cd ~/.cache/instantassist/styli.sh/ || exit 1
./styli.sh
git pull
