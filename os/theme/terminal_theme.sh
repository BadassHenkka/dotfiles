#!/bin/bash

set -e

echo "
	Setup solarized gnome-terminal theme
"

declare tmpDir="$(mktemp --directory)"

# Install the Solarized gnome-terminal theme
git clone https://github.com/aruhier/gnome-terminal-colors-solarized.git "$tmpDir"
cd "$tmpDir"
./install.sh

# Remove installation folder
rm -rf "$tmpDir"
