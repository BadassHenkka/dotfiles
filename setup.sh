#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "setup/utils.sh" && . "os/settings.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# ----------------------------------------------------------------------
# | Functions for fresh Fedora OS setup for development                |
# ----------------------------------------------------------------------

# BASIC DNF SETTINGS + UPGRADES AND DEVICE FIRMWARE UPDATES

init_fedora_setup() {

    print_in_purple "\n • Starting initial Fedora setup \n\n"

    ./os/fedora/init_fedora_setup.sh

    print_in_green "\n • Initial setup done! \n\n"

    sleep 5

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# BASH AND GIT CONFIGS

bash_and_git_configs() {

    print_in_purple "\n • Create bash and git files with symlinks + local config files for each \n\n"

    ./setup/create_symbolic_links.sh
    ./shell/create_local_shellconfig.sh
    ./git/create_local_gitconfig.sh

    print_in_green "\n • Bash and git configs done! \n\n"

    sleep 5

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# GITHUB SSH KEY

create_and_set_github_ssh_key() {

    ./git/set_github_ssh_key.sh

    print_in_green "\n • Github ssh key creation done! \n\n"

    sleep 5

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# BASIC EXTENSIONS AND PACKAGE MANAGERS

install_extensions_and_pkg_managers() {

    print_in_purple "\n • Installing basic extensions and pkg managers \n\n"

    ./os/fedora/extensions_and_pkg_managers.sh

    print_in_green "\n • Finished installing basic extensions and pkg managers! \n\n"

    sleep 5

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# DEV PACKAGES

install_dev_packages() {

    print_in_purple "\n • Installing dev packages \n\n"

    ./os/dev_packages.sh

    print_in_green "\n Dev packages installed! \n\n"

    sleep 5

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# POP!_OS THEME SETUP + SOLARIZED TERMINAL

setup_os_theme_and_terminal_style() {

    # Note that the final step of Pop Shell installation
    # is done on the last step of the OS full setup process

    print_in_purple "\n • Setting up Pop!_OS theme and Solarized terminal \n\n"

    ./os/theme/main.sh

    print_in_green "\n Theme and terminal setup done! \n\n"

    sleep 5

}

pop_shell_final_install_step() {

    cd $HOME/fedora/pop-shell && make local-install

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# APP INSTALLATION

install_apps() {

    print_in_purple "\n • Installing applications \n\n"

    ./os/apps.sh

    print_in_green "\n Apps installed! \n\n"

    sleep 5

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

fedora_setup_final() {

    # cleanup

    sudo dnf autoremove

    source ~/.bashrc

    # final general settings tweaks

    general_settings_tweaks

    echo "
        Theme notes:
        PopOS terminal preferences > Colors
        - default color for Text is #F2F2F2
        - default color for Background is #333333
    "

    echo "
        Install input/output device chooser from here
        https://extensions.gnome.org/extension/906/sound-output-device-chooser/
    "

    print_in_green "\n • Done! Make the above adjustments and choose 1 to make the final pop-shell install. \n"

    echo "
        You will be logged out but it is better to restart.
	    Remember to enable the Pop shell in the Extensions menu.
    "

    select yn in "finish" "exit"; do
        case $yn in
              finish ) pop_shell_final_install_step; break;;
                exit ) exit;;
        esac
    done

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# ----------------------------------------------------------------------
# | Main                                                               |
# ----------------------------------------------------------------------

# THE FULL SETUP PROCESS

main() {

    init_fedora_setup

    bash_and_git_configs

    create_and_set_github_ssh_key

    install_extensions_and_pkg_managers

    install_dev_packages

    setup_os_theme_and_terminal_style

    install_apps

    fedora_setup_final

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Allow calling single functions in script and run main if nothing is specified

"$@"

if [ "$1" == "" ]; then
    main
fi
