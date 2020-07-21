#!/bin/bash

rm -rf cache
mkdir cache
HELP="$(realpath .)/cache/help"
CACHE="$(realpath .)/cache/cache"

cd dm
for i in ./*; do
    echo "processing $i"
    if [ -d "$i" ]; then
        echo "processing directory $i"
        cd "$i" || exit
        CATNAME=$(grep -o '[a-z]' <<<"$i")
        echo "$CATNAME: $(cat .describe)" >>"$HELP"
        for u in ./*; do
            echo "processing subitem $u"
            SUBNAME=$(grep -o '[a-z]\.' <<<"$u" | grep -o '[a-z]')
            echo "    $SUBNAME$(grep '# assist: ' "$u" | grep -o ':.*')" >>"$HELP"
        done
        echo "" >> "$HELP"
        cd .. || exit
    else
        echo "processing item $i"
    fi
done
