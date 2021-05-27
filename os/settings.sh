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

custom_workspace_keybindings() {

    # https://github.com/pop-os/shell/issues/142#issuecomment-663079699

    # First, enable a static number of workspaces
    gsettings set org.gnome.mutter dynamic-workspaces false
    gsettings set org.gnome.desktop.wm.preferences num-workspaces 10

    # Then unbind all the GNOME default keybindings for switching between applications
    gsettings set org.gnome.shell.keybindings switch-to-application-1 []
    gsettings set org.gnome.shell.keybindings switch-to-application-2 []
    gsettings set org.gnome.shell.keybindings switch-to-application-3 []
    gsettings set org.gnome.shell.keybindings switch-to-application-4 []
    gsettings set org.gnome.shell.keybindings switch-to-application-5 []
    gsettings set org.gnome.shell.keybindings switch-to-application-6 []
    gsettings set org.gnome.shell.keybindings switch-to-application-7 []
    gsettings set org.gnome.shell.keybindings switch-to-application-8 []
    gsettings set org.gnome.shell.keybindings switch-to-application-9 []

    # Rebind them to switch between workspaces on Super + number:
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1  "['<Super>1']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2  "['<Super>2']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3  "['<Super>3']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4  "['<Super>4']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5  "['<Super>5']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-6  "['<Super>6']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-7  "['<Super>7']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-8  "['<Super>8']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-9  "['<Super>9']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-10 "['<Super>0']"

    # In addition, it's convenient to have Super + Shift + number move a window between workspaces:
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1  "['<Super><Shift>1']"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-2  "['<Super><Shift>2']"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-3  "['<Super><Shift>3']"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-4  "['<Super><Shift>4']"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-5  "['<Super><Shift>5']"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-6  "['<Super><Shift>6']"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-7  "['<Super><Shift>7']"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-8  "['<Super><Shift>8']"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-9  "['<Super><Shift>9']"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-10 "['<Super><Shift>0']"

}