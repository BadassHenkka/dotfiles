#!/bin/bash

general_settings_tweaks() {

    print_in_purple "\n • General Gnome tweaks... \n\n"

    echo "
        Disable suspend when laptop lid is closed in Tweaks General.
    "

    gsettings set org.gnome.desktop.interface enable-hot-corners false

    gsettings set org.gnome.desktop.interface clock-show-date true

    gsettings set org.gnome.desktop.interface clock-show-weekday true

    gsettings set org.gnome.desktop.interface show-battery-percentage true

}
