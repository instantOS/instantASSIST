#!/bin/bash

#############################################
## install instantASSIST from a local copy ##
#############################################

if [ -z "${ASSISTPREFIX}" ]; then
    whoami | grep -q '^root$' || exit
fi

rm -rf /tmp/assistinstall
mkdir /tmp/assistinstall

{
    [ -e assists ] && [ -e instantassist.desktop ]
} || exit

cp -r ./* /tmp/assistinstall
cd /tmp/assistinstall || exit

git pull

[ -e "${ASSISTPREFIX}"/usr/bin ] || mkdir -p "${ASSISTPREFIX}"/usr/bin
[ -e "${ASSISTPREFIX}"/usr/share/instantassist ] || mkdir -p "${ASSISTPREFIX}"/usr/share/instantassist

# remove old version
if [ -e "${ASSISTPREFIX}"/usr/share/instantassist ]; then
    rm -rf "${ASSISTPREFIX}"/usr/share/instantassist
fi

mkdir -p "${ASSISTPREFIX}"/usr/share/instantassist

./cache.sh

if ! [ -e "${ASSISTPREFIX}"/usr/share/instantassist/spotify-adblock.so ]; then
    git clone --depth=1 "https://github.com/abba23/spotify-adblock-linux.git"
    cd spotify-adblock-linux || exit 1
    sed -i '/\};/i    "audio4-fa.spotifycdn.com", //audio' whitelist.h
    make
    mv spotify-adblock.so "${ASSISTPREFIX}"/usr/share/instantassist/ || exit 1
    cd ..
    rm -rf spotify-adblock-linux
fi

chmod 755 instantassist
cp instantassist "${ASSISTPREFIX}"/usr/bin/"$1"

rm -rf .git install.sh ./*.md

chmod 755 assists/*/*.sh
chmod 755 assists/*.sh
chmod 755 utils/*.sh

installdir() {
    mkdir -p "${ASSISTPREFIX}"/usr/share/instantassist/"$1"
    cp -r "$1"/* "${ASSISTPREFIX}"/usr/share/instantassist/"$1"/
}

installdir cache
installdir assists
installdir data
installdir utils

[ -z "${ASSISTPREFIX}" ] && rm -rf /tmp/assistinstall
