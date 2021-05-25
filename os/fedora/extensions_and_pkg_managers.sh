#!/bin/bash

declare DOT=$HOME/dotfiles

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "$DOT/setup/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_gnome_ext_tweaks_appind() {

	print_in_purple "\n • Installing gnome extensions, tweaks and shell-extension-appindicator\n\n"

	sudo dnf install -y gnome-extensions-app gnome-tweaks
	sudo dnf install -y gnome-shell-extension-appindicator

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

add_flatpak_store_and_update() {

	print_in_purple "\n • Add flatpak store and update\n\n"

	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	flatpak update

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_snap() {

	print_in_purple "\n • Installing snap\n\n"

	sudo dnf install -y snapd
	sudo ln -s /var/lib/snapd/snap /snap

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

enable_extra_rpm_pkgs_and_non_free() {

	print_in_purple "\n • Enable extra rpm pkgs and non-free options\n\n"

	sudo rpm -Uvh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
	sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

	sudo dnf upgrade --refresh
	sudo dnf groupupdate core
	sudo dnf install -y rpmfusion-free-release-tainted
	sudo dnf install -y dnf-plugins-core

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_homebrew() {

	print_in_purple "\n • Installing Homebrew \n\n"

	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# ----------------------------------------------------------------------
# | Main                                                               |
# ----------------------------------------------------------------------

main() {

	install_gnome_ext_tweaks_appind

	add_flatpak_store_and_update

	install_snap

	enable_extra_rpm_pkgs_and_non_free

	install_homebrew

}

main
