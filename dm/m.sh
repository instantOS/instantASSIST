#!/usr/bin/env bash

# m = music
# opens spotify with adblock

pgrep spotify && exit 0
mkdir -p ~/.cache/spotblock
cd ~/.cache/spotblock
test -e spotify-adblock.so || wget "http://spotifyblock.surge.sh/spotify-adblock.so"
LD_PRELOAD=./spotify-adblock.so spotify
