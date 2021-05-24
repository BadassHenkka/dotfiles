#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "setup/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# ----------------------------------------------------------------------
# | Functions for fresh OS Setup                                       |
# ----------------------------------------------------------------------

# Fresh setup  on a new machine starts with step one
# The other two steps are used in setup/crons.sh

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

    print_in_purple "\n • Step one done... \n\n"

    sleep 5

}

fedora_setup_step_two() {

    print_in_purple "\n • Moving on to extensions, pkg managers and dev packages \n\n"

    ./os/fedora/extensions_and_pkg_managers.sh

    ./os/dev_packages.sh

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    print_in_green "\n Dev packages installed... \n\n"

    sleep 5

}

fedora_setup_final() {

    print_in_purple "\n • Final step - installing theme and apps \n\n"

    ./os/theme/main.sh

    ./os/apps.sh

    # cleanup

    sudo dnf autoremove

    source ~/.bashrc

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

    echo "
        GNOME TWEAKS
        - Disable "Suspend when laptop lid is closed" in General
        - Disable "Activities Overview Hot Corner" in Top Bar
        - Enable "Weekday" and "Date" in "Top Bar"
        - Enable Battery %
        - Check Autostart programs
    "

    print_in_purple "\n • Make the above adjustments and choose 1 to make the final pop-shell install. \n"

    echo "
        You will be logged out but it is probably better to restart.
	    Remember to enable the Pop shell in Extensions menu.
    "

    select yn in "finish" "exit"; do
        case $yn in
              finish ) cd $HOME/fedora/pop-shell && make local-install; break;;
                exit ) exit;;
        esac
    done

}

# ----------------------------------------------------------------------
# | Main                                                               |
# ----------------------------------------------------------------------

main() {

    fedora_setup_step_one

    fedora_setup_step_two

    fedora_setup_final

}

main
