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

if ! [ -e spotify-adblock-linux ]; then
    git clone --depth=1 "https://github.com/abba23/spotify-adblock-linux.git"
    cd spotify-adblock-linux
    sudo make install
    cd ..
fi

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
    echo "$NAME" >>apps2
done

# sort by length
cat apps2 | sort | awk '{ print length, $0 }' | sort -n -s | cut -d" " -f2- >apps
rm apps2

chmod +x dm/*.sh

cd
