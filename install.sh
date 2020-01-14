#!/usr/bin/env bash

###########################
## install instantASSIST ##
###########################

# please run as root
if ! [ "$(whoami)" = "root" ]; then
    echo "please run as root"
    exit 1
fi

source <(curl -Ls https://git.io/JerLG)
pb install
pb git

echo "installing instantASSIST"
dom='https://github.com'

if [ -e /opt/instantos/menus/dm ]; then
    rm -rf /opt/instantos/menus/dm
fi

mkdir -p /opt/instantos/menus &> /dev/null
mkdir /tmp/instantmenus &> /dev/null
cd /tmp/instantmenus

if ! [ -e /opt/instantos/spotify-adblock.so ]; then
    git clone --depth=1 "$dom/abba23/spotify-adblock-linux.git"
    cd spotify-adblock-linux
    make
    mv spotify-adblock.so /opt/instantos/spotify-adblock.so
    cd ..
    rm -rf spotify-adblock-linux
fi

rm -rf instantASSIST
gitclone instantOS/instantASSIST
cd instantASSIST
usrbin -f instantassist
rm -rf .git install.sh *.md

# build cache
cd dm
ls | grep -o '^.' | uniq >../apps
cd ..
chmod 755 dm/*.sh

mv apps /opt/instantos/menus/apps
mv dm /opt/instantos/menus/dm
mv data /opt/instantos/menus/data

cd ..
rm -rf instantASSIST
