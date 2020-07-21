#!/bin/bash

###########################
## install instantASSIST ##
###########################

git pull

ASSISTPREFIX="${ASSISTPREFIX:-/}"

[ -e "${ASSISTPREFIX}"/usr/bin ] || mkdir -p "${ASSISTPREFIX}"/usr/bin
[ -e "${ASSISTPREFIX}"/usr/share ] || mkdir -p "${ASSISTPREFIX}"/usr/share

# remove old version
if [ -e "${ASSISTPREFIX}"/usr/share/instantassist ]; then
    rm -rf "${ASSISTPREFIX}"/usr/share/instantassist
fi

bash cache.sh

if ! [ -e "${ASSISTPREFIX}"/usr/share/instantassist/spotify-adblock.so ]; then
    git clone --depth=1 "$dom/abba23/spotify-adblock-linux.git"
    cd spotify-adblock-linux
    sed -i '/\};/i    "audio4-fa.spotifycdn.com", //audio' whitelist.h
    make
    mv spotify-adblock.so "${ASSISTPREFIX}"/usr/share/instantassist/spotify-adblock.so
    cd ..
    rm -rf spotify-adblock-linux
fi

instusrbin() {
    chmod 755 "$1"
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

mv apps "${ASSISTPREFIX}"/usr/share/instantassist/menus/apps
mv dm "${ASSISTPREFIX}"/usr/share/instantassist/menus/dm
mv ex "${ASSISTPREFIX}"/usr/share/instantassist/menus/ex
mv data "${ASSISTPREFIX}"/usr/share/instantassist/menus/data

cd ..
rm -rf instantASSIST
