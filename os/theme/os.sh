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

	git clone git@github.com:BadassHenkka/comic-code-fonts.git ~/

}

style_setup_help() {
	echo "
		Setup fonts:
		First start by going to the comic-code-fonts folder and installing the fonts (gnome-font-viewer).
		Remenber to move the fontconfig folder under .config

		Go to Gnome Tweaks and change the following in Fonts

		- Interface Text: Fira Sans Book 10
		- Document Text: Roboto Slab Regular 11
		- Monospace Text: Fira Mono Regular 11 OR Comic Code 11
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

	print_in_purple "\n • Start setting up OS theme...\n\n"

	install_pop_shell

	install_fonts

	style_setup_help

}

main
