#/usr/bin/dash

# assist: search man pages
page="$(
	ls $(
		man -w |
		sed 's/:/\/man\* /g'
	)/man* |
	sed '/\//d; s/\.gz//g' |
	awk '!a[$0]++' |\
	instantmenu -p "       " -q 'search man pages' -l 12 -h -1
)"

[ -z "$page" ] && exit 0

for i in $page
do
	st -e man "$i" &
done
