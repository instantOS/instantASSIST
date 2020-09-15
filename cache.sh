#!/bin/bash

# this generates cache files for instantASSIST

rm -rf cache
mkdir cache
HELP="$(realpath .)/cache/help"
CACHE="$(realpath .)/cache/cache"
CDIR="$(realpath .)/cache"

cd assists || exit 1

# generate helpfile
echo "instantASSIST cheat sheet" > "$CACHE"

for i in ./*; do
    echo "processing $i"
    if [ -d "$i" ]; then
        echo "" >>"$HELP"
        echo "processing directory $i"
        cd "$i" || exit
        CATNAME=$(grep -o '[a-z]' <<<"$i")
        mkdir "$CDIR/$CATNAME"
        echo "$CATNAME: $(cat .describe)" >>"$HELP"
        for u in ./*; do
            echo "processing subitem $u"
            SUBNAME=$(grep -o '[a-z]\.' <<<"$u" | grep -o '[a-z]')
            echo "    $SUBNAME$(grep '# assist: ' "$u" | grep -o ':.*')" >>"$HELP"
            echo "$SUBNAME$(grep '# assist: ' "$u" | sed 's/^# assist: //g')" >>"$CDIR/$CATNAME/cache"
        done
        echo "" >>"$HELP"
        cd .. || exit
    else
        SUBNAME=$(grep -o '[a-z]\.' <<<"$i" | grep -o '[a-z]')
        echo "$SUBNAME$(grep '# assist: ' "$i" | grep -o ':.*')" >>"$HELP"
    fi
done

grep '^[a-z]' "$HELP" | sed 's/: //g' >"$CACHE"
