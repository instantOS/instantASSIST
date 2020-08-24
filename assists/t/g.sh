#!/usr/bin/env bash

# assist: reload your theming

function reload_gtk_theme() {
    theme=$(gsettings get org.gnome.desktop.interface gtk-theme)
    gsettings set org.gnome.desktop.interface gtk-theme ''
    sleep 1
    gsettings set org.gnome.desktop.interface gtk-theme "$theme"
}

reload_gtk_theme
notify-send '[instantASSIST] gtk theme has been reloaded'
