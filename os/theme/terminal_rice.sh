#!/bin/bash

set -e

echo "
	Setup shell colorscripts
"

# Install shell colorscripts from https://gitlab.com/dwt1/shell-color-scripts

mkdir ~/shell/
cd ~/shell/ && git clone https://gitlab.com/dwt1/shell-color-scripts.git
cd ~/shell/shell-color-scripts
rm -rf /opt/shell-color-scripts || return 1
sudo mkdir -p /opt/shell-color-scripts/colorscripts || return 1
sudo cp -rf colorscripts/* /opt/shell-color-scripts/colorscripts
sudo cp colorscript.sh /usr/bin/colorscript
