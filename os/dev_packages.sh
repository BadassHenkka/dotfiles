#!/bin/bash

declare DOT=$HOME/dotfiles

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "$DOT/setup/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# DEV TOOLS

dev_tools_group() {

    print_in_purple "\n • Installing the Homebrew recommended dev tools with yum\n\n"

    sudo yum groupinstall 'Development Tools'

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# CRONIE

install_cronie() {

    print_in_purple "\n • Installing cronie for cronjobs\n\n"

    sudo dnf install cronie

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# BREWFILE

install_brewfile() {

    print_in_purple "\n • Installing Brewfile from brew/Brewfile\n\n"

    # Making sure that brew is found
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

    brew bundle --file ~/dotfiles/brew/Brewfile

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# POSTGRES

install_and_setup_postgres() {

    print_in_purple "\n • Installing and setting up postgres\n\n"

    # Install, init db, enable and start service
    sudo dnf install postgresql-server
    sudo /usr/bin/postgresql-setup --initdb
    sudo systemctl enable postgresql
    sudo systemctl start postgresql

    print_in_yellow "\n Creating postgres superuser with name: $USER\n\n"

    print_in_yellow "\nType in your postgres superuser password:\n"

    read POSTGRESPWD

    sudo su - postgres bash -c "psql -c \"CREATE ROLE $USER LOGIN SUPERUSER PASSWORD '$POSTGRESPWD';\""
    sudo su - postgres bash -c "psql -c \"CREATE DATABASE $USER;\""

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# NVM AND NODE

nvm_and_node() {

    print_in_purple "\n • Installing nvm + node and use node LTS as default\n\n"

    curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash

    source ~/.bashrc

    nvm install --lts
    nvm use --lts

    source ~/.bashrc

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# TYPESCRIPT

install_typescript() {

    print_in_purple "\n • Installing typescript globally\n\n"

    npm install -g typescript

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# ----------------------------------------------------------------------
# | Main                                                               |
# ----------------------------------------------------------------------

main() {

	dev_tools_group

    install_cronie

    install_brewfile

    install_and_setup_postgres

    nvm_and_node

    install_typescript

}

main
