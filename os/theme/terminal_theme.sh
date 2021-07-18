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

# Install shell colorscripts from https://gitlab.com/dwt1/shell-color-scripts

mkdir ~/shell/
git clone https://gitlab.com/dwt1/shell-color-scripts.git ~/shell/
cd ~/shell/shell-color-scripts
rm -rf /opt/shell-color-scripts || return 1
sudo mkdir -p /opt/shell-color-scripts/colorscripts || return 1
sudo cp -rf colorscripts/* /opt/shell-color-scripts/colorscripts
sudo cp colorscript.sh /usr/bin/colorscript
