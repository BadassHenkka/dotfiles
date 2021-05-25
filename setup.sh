#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "setup/utils.sh" && . "os/settings.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# ----------------------------------------------------------------------
# | Functions for fresh Fedora OS setup for development                |
# ----------------------------------------------------------------------

# BASIC DNF SETTINGS, UPGRADES AND BASH + GIT CONFIGS

fedora_setup_step_one() {

    # Start setting up Fedora

    print_in_purple "\n • Starting initial Fedora setup \n\n"

    ./os/fedora/init_fedora_setup.sh

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Create bash + git files and symlinks

    print_in_purple "\n • Create symlinks + local config files for bash and git \n\n"

    ./setup/create_symbolic_links.sh
    ./shell/create_local_shellconfig.sh
    ./git/create_local_gitconfig.sh

    ./git/set_github_ssh_key.sh

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    print_in_green "\n • Initial setup and bash + git configs done... \n\n"

    sleep 5

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# BASIC EXTENSIONS, PACKAGE MANAGERS AND DEV PACKAGES

fedora_setup_step_two() {

    print_in_purple "\n • Installing basic extensions, pkg managers and dev packages \n\n"

    ./os/fedora/extensions_and_pkg_managers.sh

    ./os/dev_packages.sh

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    print_in_green "\n Dev packages installed... \n\n"

    sleep 5

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# POP!_OS THEME SETUP + SOLARIZED TERMINAL, APP INSTALLATION AND GENERAL TWEAKS

fedora_setup_final() {

    print_in_purple "\n • Final step - installing theme and apps \n\n"

    ./os/theme/main.sh

    ./os/apps.sh

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
              finish ) cd $HOME/fedora/pop-shell && make local-install; break;;
                exit ) exit;;
        esac
    done

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# ----------------------------------------------------------------------
# | Main                                                               |
# ----------------------------------------------------------------------

main() {

    fedora_setup_step_one

    fedora_setup_step_two

    fedora_setup_final

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Allow calling single functions in script and run main if nothing is specified

"$@"

if [ "$1" == "" ]; then
    main
fi
