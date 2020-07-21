#!/usr/bin/env dash

# assist: attach to tmux session

CHOICE="$(tmux ls | instantmenu -c -bw 4 -q 'search session' -l 40)"

[ -z "$CHOICE" ] && exit

NUMBER=$(echo "$CHOICE" | grep -o '^[^:]*')
st -e dash -c "tmux attach -t $NUMBER" &
