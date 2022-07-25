#!/bin/bash

# assist: scan local network for ssh servers

instantinstall nmap || exit 1
instantinstall net-tools || exit 1

iface="$(ip a | grep -oP '2: \K\w*')"
local_ip="$(ip -br address show primary $iface | grep -oE '((25[0-5]|2[0-4][0-9]|[01]?[0-9]?[0-9])\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9]?[0-9])')"

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

LOCALNETWORK="$(sed 's/\.[0-9]*$/.0\/24/g' <<<"$LOCALIP")"

scanservers() {
    notify-send -a instantASSIST "scanning local network for ssh servers"
    mkdir -p ~/.cache/instantos/
    nmap --open -p 22,8022 "$LOCALNETWORK" -oG - | grep 'Ports: ' | sed 's/Host: \([0-9.]*\).*Ports: \([0-9]*\).*/\1 \2/g' | sed "s/$local_ip/(local) $local_ip/g" >~/.cache/instantos/localssh
    # TODO: close button
}

if ! [ -e ~/.cache/instantos/localssh ]; then
    scanservers
fi

# ensure server list is not empty
if ! grep -q ... ~/.cache/instantos/localssh; then
    if imenu -c "no ssh servers found in the local network, rescan?"; then
        scanservers
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
            echo ":rclose"
        } | imenu -l "ssh server browser"
    )"

    [ -z "$CHOICE" ] && exit

    if grep -q ':rclose' <<<"$CHOICE"; then
        echo 'no server selected, quitting'
        exit
    fi

    if grep -q 'rescan' <<<"$CHOICE"; then
        scanservers
        processchoice
        return
    fi

    SSHADRESS="$(grep -o '^[^ ]*' <<<"$CHOICE")"
    SSHPORT="$(grep -o '[^ ]*$' <<<"$CHOICE")"

    echo "connecting to $SSHADRESS on port $SSHPORT"

}

processchoice
SSHNAME="$(imenu -i "enter username" "username" "$(whoami)")"
instantutils open terminal -e bash -c "ssh $SSHNAME@$SSHADRESS -p $SSHPORT"
