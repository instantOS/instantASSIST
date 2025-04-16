#!/bin/bash

# assist: calculator

command -v bc >/dev/null 2>&1 || instantinstall bc || exit 1

CALCULATOR="$(iconf "calculator:bc -l")"

INPUT="$(imenu -i 'calculator')"
[ -z "$INPUT" ] && exit

OUTPUT="$(printf "%g" "$($CALCULATOR <<< "$INPUT")")"

[ -z "$OUTPUT" ] && exit

CHOICE="$(echo ">>h Output: $OUTPUT
:b Copy to clipboard
:b Open in shell
:r Close" | instantmenu -h -1 -l 20 -q "Calculator")"

[ -z "$OUTPUT" ] && exit

case "$CHOICE" in
    *clipboard)
        # TODO: introduce wayland support
        echo "$OUTPUT" | xclip -selection c
        notify-send "copied $OUTPUT to clipboard"
        ;;
    *shell)
        instantutils open terminal -e bash -c "echo '$OUTPUT'; echo ''; $CALCULATOR"
        ;;
esac

