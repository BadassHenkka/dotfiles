#!/bin/bash

declare -r DOT=$HOME/dotfiles

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "$DOT/setup/utils.sh"

print_in_purple "\n • Installing basic extensions, flatpak + snap and Homebrew\n\n"

echo "
	Install gnome extensions, tweaks and app incidator
"

sudo dnf install -y gnome-extensions-app gnome-tweaks
sudo dnf install -y gnome-shell-extension-appindicator

echo "
	Add flatpak store and update
"

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak update

echo "
	Install Snap
"

sudo dnf install -y snapd
sudo ln -s /var/lib/snapd/snap /snap

echo "
	Enable extra rpm pkgs and non-free options
"

sudo rpm -Uvh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf upgrade --refresh
sudo dnf groupupdate core
sudo dnf install -y rpmfusion-free-release-tainted
sudo dnf install -y dnf-plugins-core

echo "
	Install the Homebrew recommended dev tools with yum
"

sudo yum groupinstall 'Development Tools'

echo "
	Finally install input/output device chooser from here
	https://extensions.gnome.org/extension/906/sound-output-device-chooser/
"

echo "
	GNOME TWEAKS
	- Disable "Suspend when laptop lid is closed" in General
	- Disable "Activities Overview Hot Corner" in Top Bar
	- Enable "Weekday" and "Date" in "Top Bar"
	- Enable Battery %
	- Check Autostart programs
"


echo "
	Configure the above settings manually and select 1
	to continue setup process. The machine will reboot first.
"

select yn in "continue" "exit"; do
	case $yn in
        	continue ) sudo reboot now; break;;
       	        exit ) exit;;
        esac
done
