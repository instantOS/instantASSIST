#!/bin/bash

# assist: record area of the screen

if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    if ! flatpak list | grep -q io.github.seadve.Kooha; then
        instantinstall flatpak || exit 1
        instantinstall kitty || exit 1
        kitty -e bash -c '
            flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo;
            flatpak install -y flathub io.github.seadve.Kooha
        '
    fi
    flatpak run io.github.seadve.Kooha
else
    source /usr/share/instantassist/utils/r.sh

    areascreencast
fi
