#!/bin/bash

declare DOT=$HOME/dotfiles

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "$DOT/setup/utils.sh"

print_in_purple "\n • Start setting up Pop!_OS theme...\n\n"

print_in_purple "\n Setup pop-shell extension and keyboard shortcuts \n"

# dnf install doesn't work yet with gnome 40
# so manual installation is required
git clone https://github.com/pop-os/shell.git /home/$USER/fedora/pop-shell
cd /home/$USER/fedora/pop-shell
make local-install

# Pop shell keyboard shortcuts
sudo dnf install -y make cargo rust gtk3-devel
git clone https://github.com/pop-os/shell-shortcuts /home/$USER/fedora/pop-theme/shell-shortcuts
cd /home/$USER/fedora/pop-theme/shell-shortcuts
make
sudo make install
pop-shell-shortcuts

print_in_purple "\n Setup Pop GTK theme\n\n"

# POP GTK THEME
sudo dnf install -y sassc meson glib2-devel
git clone https://github.com/pop-os/gtk-theme /home/$USER/fedora/pop-theme/gtk-theme
cd /home/$USER/fedora/pop-theme/gtk-theme
meson build && cd build
ninja
sudo ninja install

gsettings set org.gnome.desktop.interface gtk-theme "Pop"

print_in_purple "\n Set up Pop icon theme\n\n"

# POP ICON THEME
git clone https://github.com/pop-os/icon-theme /home/$USER/fedora/pop-theme/icon-theme
cd /home/$USER/fedora/pop-theme/icon-theme
meson build
sudo ninja -C "build" install

gsettings set org.gnome.desktop.interface icon-theme "Pop"
gsettings set org.gnome.desktop.interface cursor-theme "Pop"

print_in_purple "\n Setup Pop Fonts\n\n"

# FONTS

sudo dnf install -y fira-code-fonts 'mozilla-fira*' 'google-roboto*'

echo "
	After setup process is done, logout and log in

	Activate Pop Shell in Extensions App (no native window placement)
"

echo "
	Setup Fonts
	For now, go to Gnome Tweaks and change the following in Fonts

	- Interface Text: Fira Sans Book 10
	- Document Text: Roboto Slab Regular 11
	- Monospace Text: Fira Mono Regular 11
	- Legacy Window Titles: Fira Sans SemiBold 10
	- Hinting: Slight
	- Antialiasing: Standard (greyscale)
	- Scaling Factor: 1.00
"

echo "
	Setup Pop Gnome Terminal Theme

	Open terminal, go to preferences and change theme variant to default
	in the Global tab. Then create a new Profile called Pop with the following:

	Text
		Custom font: Fira Mono 12
		Deactivate Terminal bell
	Colors
		Deactivate Use colors from system theme
		Built-in schemes: Custom
		Default color: Text #F2F2F2 | Background: #333333
		Bold color (unchecked) #73C48F
		Cursor color (checked): Text #49B9C7 | Background: #F6F6F6
		Highlight color (checked): Text #FFFFFF | Background: #48B9C7
		Uncheck Transparend background

		Some of these will get overridden when installing
		the solarize gnome terminal package.	
"

echo "Right click on the Pop profile and set as default"
