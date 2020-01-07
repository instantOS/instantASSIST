#!/usr/bin/env bash

#################################################
## install paperbenni shortcut dmenu shortcuts ##
#################################################
source <(curl -Ls https://git.io/JerLG)
pb install

echo "installing paperbenni's dmenu menus"
cd

dom='https://github.com'

if [ -e paperbenni/menus ]; then
    rm -rf paperbenni/menus
fi

mkdir -p paperbenni/menus

cd paperbenni
mkdir screenshots &>/dev/null
mkdir recordings music &>/dev/null

if ! [ -e spotify-adblock-linux ]; then
    git clone --depth=1 "$dom/abba23/spotify-adblock-linux.git"
    cd spotify-adblock-linux
    sudo make install
    cd ..
fi

gclone menus
cd menus
usrbin paperapps
rm -rf .git install.sh
rm *.md

# build cache
cd dm
ls | grep -o '^.' | uniq >../apps
cd ..

chmod +x dm/*.sh

cd
