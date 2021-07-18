#!/bin/bash

declare DOT=$HOME/dotfiles

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "$DOT/setup/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_hostname() {

    print_in_purple "\n • Setting hostname... \n\n"

    print_in_yellow "\nType in your hostname:\n"
    read HOSTNAME
    hostnamectl set-hostname $HOSTNAME

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_dnf_configs() {

    print_in_purple "\n • Setting DNF configs... \n\n"

    echo 'fastestmirror=1' | sudo tee -a /etc/dnf/dnf.conf
    echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf
    echo 'deltarpm=true' | sudo tee -a /etc/dnf/dnf.conf

    cat /etc/dnf/dnf.conf

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

upgrade_dnf() {

    print_in_purple "\n • Upgrading... \n\n"

    sudo dnf upgrade --refresh
    sudo dnf check
    sudo dnf autoremove

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

update_device_firmware() {

    print_in_purple "\n • Updating device firmwares... \n\n"

    sudo fwupdmgr get-devices
    sudo fwupdmgr refresh --force
    sudo fwupdmgr get-updates
    sudo fwupdmgr update

    print_in_yellow "\n !!! Don't restart yet if doing full setup! \n\n"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_xclip() {

    print_in_purple "\n • Installing xclip for setup process... \n\n"

    sudo dnf install -y xclip

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# ----------------------------------------------------------------------
# | Main                                                               |
# ----------------------------------------------------------------------

main() {

    set_hostname

    set_dnf_configs

    upgrade_dnf

    update_device_firmware

    install_xclip

}

main
