#!/bin/bash

declare DOT=$HOME/dotfiles

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "$DOT/setup/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

pop_shell() {

	# Pop shell dnf install doesn't work yet with gnome 40
	# so manual installation is required
	git clone https://github.com/pop-os/shell.git $HOME/fedora/pop-shell
	cd $HOME/fedora/pop-shell
	make local-install

}

pop_shell_keyboard_shortcuts() {

	sudo dnf install -y make cargo rust gtk3-devel
	git clone https://github.com/pop-os/shell-shortcuts $HOME/fedora/pop-theme/shell-shortcuts
	cd $HOME/fedora/pop-theme/shell-shortcuts
	make
	sudo make install
	pop-shell-shortcuts

}

pop_GTK_theme() {

	sudo dnf install -y sassc meson glib2-devel
	git clone https://github.com/pop-os/gtk-theme $HOME/fedora/pop-theme/gtk-theme
	cd $HOME/fedora/pop-theme/gtk-theme
	meson build && cd build
	ninja
	sudo ninja install

	gsettings set org.gnome.desktop.interface gtk-theme "Pop"

}

pop_icon_theme() {

	git clone https://github.com/pop-os/icon-theme $HOME/fedora/pop-theme/icon-theme
	cd $HOME/fedora/pop-theme/icon-theme
	meson build
	sudo ninja -C "build" install

	gsettings set org.gnome.desktop.interface icon-theme "Pop"
	gsettings set org.gnome.desktop.interface cursor-theme "Pop"

}

pop_fonts() {

	sudo dnf install -y fira-code-fonts 'mozilla-fira*' 'google-roboto*'

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n • Start setting up Pop!_OS theme...\n\n"

print_in_purple "\n Setup pop-shell extension \n\n"

pop_shell

print_in_purple "\n Setup Pop keyboard shortcuts \n\n"

pop_shell_keyboard_shortcuts

print_in_purple "\n Setup Pop GTK theme\n\n"

pop_GTK_theme

print_in_purple "\n Setup Pop icon theme\n\n"

pop_icon_theme

print_in_purple "\n Install Pop Fonts\n\n"

pop_fonts

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

echo "
	Setup Fonts
	Go to Gnome Tweaks and change the following in Fonts

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
