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
        DIRNAME=$(grep '[a-z]' <<<"$i")
        echo "$DIRNAME: $(cat .describe)" >>"$HELP"
        for u in ./*; do
            echo "processing subitem $u"
            SUBNAME=$(grep '[a-z]' <<<$u)
            echo "    $SUBNAME$(grep '# assist: ' "$u" | grep -o ':.*')" >>"$HELP"
        done
        cd .. || exit
    else
        echo "processing item $i"
    fi
done
