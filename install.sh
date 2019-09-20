#!/usr/bin/env bash

echo "installing paperbenni's dmenu menus"
cd
rm -rf paperbenni
mkdir paperbenni
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
