#!/bin/bash

declare DOT=$HOME/dotfiles

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "$DOT/setup/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

git_clone_pop_shell() {

	print_in_purple "\n • Clone pop-shell extension from github (it'll be installed last in the setup process) \n\n"

	# Pop shell dnf install doesn't work yet with gnome 40
	# so manual installation is required

	# The pop-shell install is done on the last step of the full setup process because it restarts the shell
	# and thus stops any other install scripts
	git clone https://github.com/pop-os/shell.git $HOME/fedora/pop-shell

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

pop_shell_keyboard_shortcuts() {

	print_in_purple "\n • Setup Pop keyboard shortcuts \n\n"

	sudo dnf install -y make cargo rust gtk3-devel
	git clone https://github.com/pop-os/shell-shortcuts $HOME/fedora/pop-theme/shell-shortcuts
	cd $HOME/fedora/pop-theme/shell-shortcuts
	make
	sudo make install

	print_in_yellow "\n Show pop shell keyboard shortcuts (type 'pop-shell-shortcuts' in terminal)\n\n"

	pop-shell-shortcuts

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

pop_GTK_theme() {

	print_in_purple "\n • Setup Pop GTK theme\n\n"

	sudo dnf install -y sassc meson glib2-devel
	git clone https://github.com/pop-os/gtk-theme $HOME/fedora/pop-theme/gtk-theme
	cd $HOME/fedora/pop-theme/gtk-theme
	meson build && cd build
	ninja
	sudo ninja install

	gsettings set org.gnome.desktop.interface gtk-theme "Pop"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

pop_icon_theme() {

	print_in_purple "\n • Setup Pop icon theme\n\n"

	git clone https://github.com/pop-os/icon-theme $HOME/fedora/pop-theme/icon-theme
	cd $HOME/fedora/pop-theme/icon-theme
	meson build
	sudo ninja -C "build" install

	gsettings set org.gnome.desktop.interface icon-theme "Pop"
	gsettings set org.gnome.desktop.interface cursor-theme "Pop"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

pop_fonts() {

	print_in_purple "\n • Install Pop Fonts\n\n"

	sudo dnf install -y fira-code-fonts 'mozilla-fira*' 'google-roboto*'

}

pop_style_setup_help() {
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

	echo "
		Click on the Pop profile arrow and set it as default
	"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# ----------------------------------------------------------------------
# | Main                                                               |
# ----------------------------------------------------------------------

main() {

	print_in_purple "\n • Start setting up Pop!_OS theme...\n\n"

	git_clone_pop_shell

	pop_shell_keyboard_shortcuts

	pop_GTK_theme

	pop_icon_theme

	pop_fonts

	pop_style_setup_help

}

main
