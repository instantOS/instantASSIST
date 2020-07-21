#!/bin/bash

#############################################
## install instantASSIST from a local copy ##
#############################################

whoami | grep -q '^root$' || exit

rm -rf /tmp/assistinstall
cp -r ./* /tmp/assistinstall
cd /tmp/assistinstall || exit

git pull

[ -e "${ASSISTPREFIX}"/usr/bin ] || mkdir -p "${ASSISTPREFIX}"/usr/bin
[ -e "${ASSISTPREFIX}"/usr/share ] || mkdir -p "${ASSISTPREFIX}"/usr/share

# remove old version
if [ -e "${ASSISTPREFIX}"/usr/share/instantassist ]; then
    rm -rf "${ASSISTPREFIX}"/usr/share/instantassist
fi

bash cache.sh

if ! [ -e "${ASSISTPREFIX}"/usr/share/instantassist/spotify-adblock.so ]; then
    git clone --depth=1 "https://github.com/abba23/spotify-adblock-linux.git"
    cd spotify-adblock-linux || exit 1
    sed -i '/\};/i    "audio4-fa.spotifycdn.com", //audio' whitelist.h
    make
    mv spotify-adblock.so "${ASSISTPREFIX}"/usr/share/instantassist/spotify-adblock.so
    cd ..
    rm -rf spotify-adblock-linux
fi

chmod 755 instantassist
cp instantassist "${ASSISTPREFIX}"/usr/bin/"$1"

rm -rf .git install.sh ./*.md

chmod 755 assists/*.sh
chmod 755 utils/*.sh

cp -r cache "${ASSISTPREFIX}"/usr/share/instantassist/cache
cp -r assists "${ASSISTPREFIX}"/usr/share/instantassist/assists
cp -r data "${ASSISTPREFIX}"/usr/share/instantassist/data
cp -r utils "${ASSISTPREFIX}"/usr/share/instantassist/utils
