#!/bin/bash

# assist: calculator

CALCULATOR="$(iconf "calculator:bc -l")"

INPUT="$(imenu -i 'calculator')"
[ -z "$INPUT" ] && exit

OUTPUT="$(printf "%g" "$($CALCULATOR <<< "$INPUT")")"

[ -z "$OUTPUT" ] && exit

CHOICE="$(echo ">>h Output: $OUTPUT
:b Copy top clipboard
:b Open in shell
:r Close" | instantmenu -h -1 -l 20 -q "Calculator")"

[ -z "$OUTPUT" ] && exit

case "$CHOICE" in
    *clipboard)
        echo "$OUTPUT" | xclip -selection c
        notify-send "[instantASSIST] copied $OUTPUT to clipboard"
        ;;
    *shell)
        st -e bash -c "echo '$OUTPUT'; echo ''; $CALCULATOR"
        ;;
esac

