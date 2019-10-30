#!/usr/bin/env bash

#################################################
## install paperbenni shortcut dmenu shortcuts ##
#################################################

echo "installing paperbenni's dmenu menus"
cd

# keep downloaded music
if [ -e paperbenni/menus ]; then
    rm -rf paperbenni/menus
fi

mkdir -p paperbenni/menus

cd paperbenni
mkdir screenshots &>/dev/null
mkdir recordings music &>/dev/null
git clone --depth=1 "https://github.com/abba23/spotify-adblock-linux.git"
cd spotify-adblock-linux
sudo make install
cd ..
rm .rf spotify-adblock-linux

git clone --depth=1 "https://github.com/paperbenni/menus.git"
cd menus
sudo mv paperapps /usr/bin
sudo chmod +x /usr/bin/paperapps
rm -rf .git
rm *.md
rm install.sh

# build apps cache
rm apps
for i in dm/*; do
    FILENAME=${i#*/}
    NAME=${FILENAME%.*}
    echo "$NAME" >>apps
done

chmod +x dm/*.sh

cd
