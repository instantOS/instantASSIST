#!/usr/bin/env bash

echo "installing paperbenni's dmenu menus"
cd

# keep downloaded music
if [ -e paperbenni]; then
    if [ -e paperbenni/music]; then
        echo "backing up music"
        mv paperbenni/music .cache/papermusic
    fi
    rm -rf paperbenni
    mkdir paperbenni
fi

cd paperbenni
mkdir screenshots
mkdir recordings music
git clone --depth=1 "https://github.com/abba23/spotify-adblock-linux.git"
cd spotify-adblock-linux
sudo make iństall
cd ..
git clone --depth=1 "https://github.com/paperbenni/menus.git"
cd menus
sudo mv paperapps /usr/bin
sudo chmod +x /usr/bin/paperapps
rm -rf .git
rm *.md
rm install.sh
chmod +x dm/*.sh

cd

if [ -e .papermusic ]; then
    echo "restoring music"
    mv .papermusic paperbenni/music
fi
