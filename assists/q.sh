#!/bin/bash

[ -e /usr/bin/tuxi ] || instantinstall tuxi-git && \

# assist: ask tuxi a question

# TODO (maybe?) add search history/history of outputs
{
NEWQUESTION=true
while [ -n "$NEWQUESTION" ]; do

    unset NEWQUESTION
    QUESTION="$(echo "" | instantmenu -p 'ask tuxi a question')"
    [ -z "$QUESTION" ] && exit

    ANWSER="$(tuxi -r -q "$QUESTION")"

    CHOICE="$(echo "$(sed "s/^/>>h/" <<< $ANWSER)
:b New question
:b Copy to clipboard
:r Close" | instantmenu -h -1 -l 20 -q Tuxi -ps $(wc -l <<< $ANWSER))"

    case "$CHOICE" in
    *question)
        NEWQUESTION=true
        ;;
    *clipboard)
        echo "$ANWSER" | xclip -selection c
        notify-send "copied anwser to clipboard"
        ;;
    esac

done
}
