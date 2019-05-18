#!/usr/bin/env bash
rm -rf ~/paperbenni
mkdir -p ~/paperbenni/screenshots
pushd ~/paperbenni
mkdir recordings
mkdir music
mkdir menus
popd
cp -r ./* ~/paperbenni/menus
