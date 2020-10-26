#!/bin/bash

# assist: ssh scanner

instantinstall nmap
getlocalip() {
    TEMPIP="$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')"
    if grep -q '192' <<<"$TEMPIP"; then
        echo "$TEMPIP" | grep '192' | tail -1
    else
        echo "$TEMPIP" | tail -1
    fi
}

LOCALIP="$(getlocalip)"

if [ -z "$LOCALIP" ]; then
    imenu -m "could not scan local network"
    exit 1
fi

LOCALNETWORK="$(sed 's/\.[0-9]*$/.0\/24/g' <<< "$LOCALIP")"

scanservers() {
    notify-send "scanning local network for ssh servers"
    instantinstall nmap
    mkdir -p ~/.cache/instantos/
    nmap --open -p 22,8022 "$LOCALNETWORK" -oG - | grep 'Ports: ' | sed 's/Host: \([0-9.]*\).*Ports: \([0-9]*\).*/\1 \2/g' >~/.cache/instantos/localssh
}

if ! [ -e ~/.cache/instantos/localssh ]; then
    scanservers
fi

# ensure server list is not empty
if ! grep -q ... ~/.cache/instantos/localssh; then
    if imenu -c "no ssh servers found in the local network, rescan?"; then
        while ! grep -q ... ~/.cache/instantos/localssh; do
            if imenu -c "no ssh servers found in the local network, rescan?"; then
                scanservers
            else
                exit 1
            fi
        done
    fi
fi

processchoice() {

    CHOICE="$(
        {
            echo "rescan servers"
            cat ~/.cache/instantos/localssh
        } | imenu -l "ssh server browser"
    )"

    [ -z "$CHOICE" ] && exit

    if grep -q 'rescan' <<< "$CHOICE"
    then
        scanservers
        processchoice
        return
    fi

    SSHADRESS="$(grep -o '^[^ ]*' <<< "$CHOICE")"
    SSHPORT="$(grep -o '[^ ]*$' <<< "$CHOICE")"

    echo "connecting to $SSHADRESS on port $SSHPORT"

}

processchoice
SSHNAME="$(imenu -i "enter username" "username" "$(whoami)")"
st -e bash -c "ssh $SSHNAME@$SSHADRESS -p $SSHPORT"
