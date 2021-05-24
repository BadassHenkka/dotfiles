#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "setup/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# ----------------------------------------------------------------------
# | Helper Functions                                                   |
# ----------------------------------------------------------------------

setup_cronie() {
    print_in_purple "\n • Installing cronie for cronjobs helping in setup process...\n\n"

    sudo dnf install cronie
}

# ----------------------------------------------------------------------
# | Main functions for fresh OS Setup                                  |
# ----------------------------------------------------------------------

# Fresh setup  on a new machine starts with step one
# The other two steps are used in setup/crons.sh

fedora_setup_step_one() {

    setup_cronie

    # Setup cronjob to be done after the first reboot
    (crontab -l 2>/dev/null; echo "@reboot sh $HOME/dotfiles/setup/crons.sh setup_cron_one") | crontab -

    print_in_purple "\n • Start initial Fedora setup \n\n"

    ./os/fedora/init_fedora_setup.sh

}

fedora_setup_step_two() {

    print_in_purple "\n • Install Homebrew \n\n"

    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Create bash + git files and symlinks - the configs and homebrew will then work after second reboot

    print_in_purple "\n • Create symlinks + local config files for bash and git \n\n"

    ./setup/create_symbolic_links.sh
    ./shell/create_local_shellconfig.sh
    ./git/create_local_gitconfig.sh

    print_in_purple "\n • Moving on to extensions and pkg managers \n\n"

    ./os/fedora/extensions_and_pkg_managers.sh

}

fedora_setup_final() {

    print_in_purple "\n • Starting final Fedora setup step \n\n"

    # Typescript is needed for setting up the PopOS theme.
    # Node is needed for that and it's easy to install with brew
    # so might as well just install all dev packages at this point.
    ./os/dev_packages.sh

    ./os/theme/main.sh

    ./os/apps.sh

    ./git/set_github_ssh_key.sh

    # cleanup

    sudo dnf autoremove

    print_in_purple "\n • All done! Logout and log in. Activate Pop Shell in Extensions App. \n\n"

    echo "
        Notes:
        PopOS terminal preferences > Colors
        - default color for Text is #F2F2F2
        - default color for Background is #333333
    "

}

"$@"
