#!/bin/bash

declare DOT=$HOME/dotfiles

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "$DOT/setup/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_pop_shell() {

	print_in_purple "\n • Install pop shell \n\n"

	sudo dnf install -y gnome-shell-extension-pop-shell

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_fonts() {

	print_in_purple "\n • Install Fonts\n\n"

	sudo dnf install -y fira-code-fonts 'mozilla-fira*' 'google-roboto*'

}

style_setup_help() {
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
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# ----------------------------------------------------------------------
# | Main                                                               |
# ----------------------------------------------------------------------

main() {

	print_in_purple "\n • Start setting up Pop!_OS theme...\n\n"

	install_pop_shell

	install_fonts

	style_setup_help

}

main
