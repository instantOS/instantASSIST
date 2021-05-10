#!/usr/bin/dash

# assist: attach to tmux session

CHOICE="$(tmux ls -F '#{?session_attached,:#{?session_many_attached,y ,b },:r ﴹ} #W [#{b:pane_current_path}] (#{session_windows}) ###{session_name}	#{?session_attached,attached,}' | instantmenu -c -bw 4 -q 'search session' -l 15 -w -1 -p 'attach to tmux session' -h -1 -g 4 -r | sed 's/^.*#//;s/	.*$//')"

[ -z "$CHOICE" ] && exit

NUMBER=$(echo "$CHOICE" | grep -o '^[^:]*')
instantutils open terminal -e dash -c "tmux attach -t $NUMBER" &
