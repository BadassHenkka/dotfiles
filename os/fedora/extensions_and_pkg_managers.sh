#!/bin/bash

declare DOT=$HOME/dotfiles

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "$DOT/setup/utils.sh"

print_in_purple "\n • Installing basic extensions, flatpak + snap and Homebrew\n\n"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

echo "
	Install gnome extensions, tweaks and app incidator
"

sudo dnf install -y gnome-extensions-app gnome-tweaks
sudo dnf install -y gnome-shell-extension-appindicator

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

echo "
	Add flatpak store and update
"

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak update

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

echo "
	Install Snap
"

sudo dnf install -y snapd
sudo ln -s /var/lib/snapd/snap /snap

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

echo "
	Enable extra rpm pkgs and non-free options
"

sudo rpm -Uvh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf upgrade --refresh
sudo dnf groupupdate core
sudo dnf install -y rpmfusion-free-release-tainted
sudo dnf install -y dnf-plugins-core

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n • Install Homebrew \n\n"

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
