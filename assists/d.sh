#!/usr/bin/dash

# assist: attach to tmux session

CHOICE="$(tmux ls | instantmenu -c -bw 4 -q 'search session' -l 40 -w -1 -p 'attach to tmux session')"

[ -z "$CHOICE" ] && exit

NUMBER=$(echo "$CHOICE" | grep -o '^[^:]*')
instantutils open terminal -e dash -c "tmux attach -t $NUMBER" &
