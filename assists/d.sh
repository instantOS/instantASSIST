#!/usr/bin/env sh

# assist: attach to tmux session

CHOICE="$(tmux ls | instantmenu -c -bw 4 -q 'search session' -l 40 -w -1 -p 'attach to tmux session')"

[ -z "$CHOICE" ] && exit

NUMBER=$(echo "$CHOICE" | grep -o '^[^:]*')
st -e dash -c "tmux attach -t $NUMBER" &
