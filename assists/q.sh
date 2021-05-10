#!/bin/bash

[ -e /usr/bin/tuxi ] || instantinstall tuxi-git && \

# assist: ask tuxi a question

# TODO (maybe?) add search history/history of outputs
{
QUESTION="$(echo "" | instantmenu -p 'ask tuxi a question')"
[ -z "$QUESTION" ] && exit

instantutils open terminal -e "dash" -c "tuxi '$QUESTION' | less -r --mouse --wheel-lines 3"
}
