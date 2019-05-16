#!/usr/bin/env bash
cd
rm -rf paperbenni/menus
mkdir paperbenni
cd paperbenni
mkdir screenshots
mkdir recordings
git clone --depth=1 "https://github.com/paperbenni/menus.git"
cd menus
sudo mv paperapps /usr/bin
sudo chmod +x /usr/bin/paperapps
rm -rf .git
rm *.md
rm install.sh
chmod +x dm/*.sh
