#!/bin/bash

declare DOT=$HOME/dotfiles

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "$DOT/setup/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_tlp_battery_management() {

        print_in_purple "\n • Installing tlp battery management \n\n"

        sudo dnf install tlp tlp-rdw

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

thinkpad_pkgs() {

        print_in_purple "\n • Installing thinkpad packages \n\n"

        sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
        sudo dnf install https://repo.linrunner.de/fedora/tlp/repos/releases/tlp-release.fc$(rpm -E %fedora).noarch.rpm
        sudo dnf install kernel-devel akmod-acpi_call akmod-tp_smapi

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

optional_thinkpad_pkg_install() {

        print_in_purple "\n • If you're setting up a Thinkpad - select 1 \n"

        select yn in "thinkpad" "other"; do
                case $yn in
                        thinkpad ) thinkpad_pkgs; break;;
                        other ) break;;
                esac
        done

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

install_git_kraken_flatpak() {

        print_in_purple "\n • Installing Git Kraken \n\n"

        flatpak install -y gitkraken

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

# ----------------------------------------------------------------------
# | Main                                                               |
# ----------------------------------------------------------------------

main() {

        install_tlp_battery_management

        optional_thinkpad_pkg_install

        install_multimedia_codecs

        install_git_kraken_flatpak

        install_VSCode_and_set_inotify_max_user_watches

        install_VLC

}

main
