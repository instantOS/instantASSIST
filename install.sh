#!/bin/bash

###########################
## install instantASSIST ##
###########################

# please run as root
if [ -z "$ASSISTPREFIX" ]; then
    if ! [ "$(whoami)" = "root" ]; then
        echo "please run as root"
        exit 1
    fi
else
    mkdir -p "${ASSISTPREFIX}"/usr/bin
    mkdir -p "${ASSISTPREFIX}"/opt
fi

source /usr/share/paperbash/import.sh
pb install
pb git

echo "installing instantASSIST"
dom='https://github.com'

if [ -e "${ASSISTPREFIX}"/opt/instantos/menus/dm ]; then
    rm -rf "${ASSISTPREFIX}"/opt/instantos/menus/dm
fi

rm -rf "${ASSISTPREFIX}"/opt/instantos/menus
mkdir -p "${ASSISTPREFIX}"/opt/instantos/menus &>/dev/null
mkdir /tmp/instantmenus &>/dev/null
cd /tmp/instantmenus

if ! [ -e "${ASSISTPREFIX}"/opt/instantos/spotify-adblock.so ]; then
    git clone --depth=1 "$dom/abba23/spotify-adblock-linux.git"
    cd spotify-adblock-linux
    sed -i '/\};/i    "audio4-fa.spotifycdn.com", //audio' whitelist.h
    make
    mv spotify-adblock.so "${ASSISTPREFIX}"/opt/instantos/spotify-adblock.so
    cd ..
    rm -rf spotify-adblock-linux
fi

rm -rf instantASSIST
gitclone instantOS/instantASSIST
cd instantASSIST

instusrbin() {
    chmod +x "$1"
    mv "$1" "${ASSISTPREFIX}"/usr/bin/"$1"
}

instusrbin instantassist
instusrbin instantdoc

rm -rf .git install.sh ./*.md

# build cache
cd dm
ls | grep -o '^.' | uniq >../apps
cd ..
chmod 755 dm/*.sh
chmod 755 ex/*.sh

mv apps "${ASSISTPREFIX}"/opt/instantos/menus/apps
mv dm "${ASSISTPREFIX}"/opt/instantos/menus/dm
mv ex "${ASSISTPREFIX}"/opt/instantos/menus/ex
mv data "${ASSISTPREFIX}"/opt/instantos/menus/data

cd ..
rm -rf instantASSIST
