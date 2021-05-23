#!/bin/bash

declare -r DOT=$HOME/dotfiles

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "$DOT/setup/utils.sh"

print_in_purple "\n Install dev packages with brew, install nvm + node and install Typescript"

# BREWFILES

echo "Install Brewfile"

brew bundle --file ~/dotfiles/brew/Brewfile

# NODE

echo "Install and use node LTS as default"

nvm install --lts
nvm use --lts

# TYPESCRIPT

echo "Install typescript globally"

npm install -g typescript

print_in_green "\n Packages installed, nvm+node setup and Typescript installed..."

sleep 3
