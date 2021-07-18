#!/bin/bash

declare DOT=$HOME/dotfiles

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "$DOT/setup/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_tlp_battery_management() {

        print_in_purple "\n • Installing tlp battery management \n\n"

        sudo dnf install -y tlp tlp-rdw

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_multimedia_codecs() {

        print_in_purple "\n • Installing multimedia codecs... \n\n"

        sudo dnf groupupdate sound-and-video
        sudo dnf install -y libdvdcss
        sudo dnf install -y gstreamer1-plugins-{bad-\*,good-\*,ugly-\*,base} gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel ffmpeg gstreamer-ffmpeg
        sudo dnf install -y lame\* --exclude=lame-devel
        sudo dnf group upgrade --with-optional Multimedia

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_VSCode_and_set_inotify_max_user_watches() {

        print_in_purple "\n • Installing VSCode \n\n"

        sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
        sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
        sudo dnf check-update
        sudo dnf install -y code

        echo 'fs.inotify.max_user_watches=524288' | sudo tee -a /etc/sysctl.conf
        sudo sysctl -p

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_VLC() {

        print_in_purple "\n • Installing VLC \n\n"

        sudo dnf install -y vlc

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_ulauncher() {

        print_in_purple "\n • Installing Ulauncher \n\n"

        sudo dnf install -y ulauncher

        # https://github.com/Ulauncher/Ulauncher/wiki/Hotkey-In-Wayland
        sudo dnf install -y wmctrl

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_chrome() {

        print_in_purple "\n • Installing Chrome \n\n"

        sudo dnf config-manager --set-enabled google-chrome

        sudo dnf install -y google-chrome-stable

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# ----------------------------------------------------------------------
# | Main                                                               |
# ----------------------------------------------------------------------

main() {

        install_tlp_battery_management

        install_multimedia_codecs

        install_VSCode_and_set_inotify_max_user_watches

        install_VLC

        install_ulauncher

        install_chrome

}

main
