#!/usr/bin/env bash

# this script is only for development purposes

rm -rf ~/paperbenni
mkdir -p ~/paperbenni/screenshots
pushd ~/paperbenni
mkdir recordings
mkdir music
mkdir menus
popd
cp -r ./* ~/paperbenni/menus
