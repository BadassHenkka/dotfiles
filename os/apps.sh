#!/bin/bash

declare DOT=$HOME/dotfiles

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "$DOT/setup/utils.sh"

print_in_purple "\n Install applications \n\n"

# TLP for laptop battery management

sudo dnf install tlp tlp-rdw

# xclip for copying stuff to clipboard in scripts

sudo dnf install xclip

thinkpad_pkgs() {

	sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
	sudo dnf install https://repo.linrunner.de/fedora/tlp/repos/releases/tlp-release.fc$(rpm -E %fedora).noarch.rpm
	sudo dnf install kernel-devel akmod-acpi_call akmod-tp_smapi

}

print_in_purple "\n If you're setting up a Thinkpad - select 1 \n"

select yn in "thinkpad" "other"; do
        case $yn in
                thinkpad ) thinkpad_pgks; break;;
                other ) break;;
        esac
done

# Multimedia codecs

print_in_purple "\n Some multimedia codecs... \n\n"

sudo dnf groupupdate sound-and-video
sudo dnf install -y libdvdcss
sudo dnf install -y gstreamer1-plugins-{bad-\*,good-\*,ugly-\*,base} gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel ffmpeg gstreamer-ffmpeg
sudo dnf install -y lame\* --exclude=lame-devel
sudo dnf group upgrade --with-optional Multimedia

# Gitkraken
flatpak install -y gitkraken

# VSCode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf check-update
sudo dnf install -y code

echo 'fs.inotify.max_user_watches=524288' | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

# VLC

sudo dnf install -y vlc
