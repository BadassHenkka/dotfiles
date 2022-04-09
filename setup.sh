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

    /bin/bash -c "$(curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash)"

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

# OS THEME SETUP + TERMINAL TWEAKS

setup_os_theme_and_terminal_style() {

    print_in_purple "\n • Setting up OS theme and terminal tweaks \n\n"

    ./os/theme/main.sh

    print_in_green "\n Theme and terminal setup done! \n\n"

    sleep 5

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

    # final tweaks

    general_settings_tweaks

    custom_workspace_keybindings

    custom_keybindings

    echo "
        Gnome extensions:
        https://extensions.gnome.org/extension/906/sound-output-device-chooser/
        https://extensions.gnome.org/extension/4158/gnome-40-ui-improvements/
        https://extensions.gnome.org/extension/3193/blur-my-shell/
        https://extensions.gnome.org/extension/1145/sensory-perception/
        https://extensions.gnome.org/extension/19/user-themes/
    "

    print_in_green "\n • All done! Install the suggested extensions and restart. \n"

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
