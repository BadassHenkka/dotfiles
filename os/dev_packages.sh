#!/bin/bash

declare DOT=$HOME/dotfiles

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "$DOT/setup/utils.sh"

print_in_purple "\n Install dev packages \n\n"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Yum dev tools

print_in_purple "\n Install the Homebrew recommended dev tools with yum\n\n"

sudo yum groupinstall 'Development Tools'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# BREWFILES

echo "Install Brewfile"

# Making sure that brew is found when the shell script runs
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

brew bundle --file ~/dotfiles/brew/Brewfile

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# POSTGRES

# Install, init db, enable and start service
sudo dnf install postgresql-server
sudo /usr/bin/postgresql-setup --initdb
sudo systemctl enable postgresql
sudo systemctl start postgresql

echo "
    Creating postgres superuser with name: $USER
"
echo "Type in your postgres superuser password:"
read POSTGRESPWD

sudo su - postgres bash -c "psql -c \"CREATE ROLE $USER LOGIN SUPERUSER PASSWORD '$POSTGRESPWD';\""
sudo su - postgres bash -c "psql -c \"CREATE DATABASE $USER;\""

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# NODE

echo "Install nvm + node and use node LTS as default"

curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash

source ~/.bashrc

nvm install --lts
nvm use --lts

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# TYPESCRIPT

source ~/.bashrc

echo "Install typescript globally"

npm install -g typescript
