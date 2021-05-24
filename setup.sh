#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "setup/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# ----------------------------------------------------------------------
# | Main functions for fresh OS Setup                                  |
# ----------------------------------------------------------------------

# Fresh setup  on a new machine starts with step one
# The other two steps are used in setup/crons.sh

fedora_setup_step_one() {

    # Create bash + git files and symlinks

    print_in_purple "\n • Create symlinks + local config files for bash and git \n\n"

    ./setup/create_symbolic_links.sh
    ./shell/create_local_shellconfig.sh
    ./git/create_local_gitconfig.sh

    ./git/set_github_ssh_key.sh

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Install cronie and setup cronjob to be done after the first reboot

    print_in_purple "\n • Installing cronie for cronjobs helping in setup process...\n\n"

    sudo dnf install cronie

    (crontab -l 2>/dev/null; echo "@reboot sh $HOME/dotfiles/setup/crons.sh setup_cron_one") | crontab -

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Start setting up Fedora

    print_in_purple "\n • Starting initial Fedora setup \n\n"

    # restart after this
    ./os/fedora/init_fedora_setup.sh

}

fedora_setup_step_two() {

    print_in_purple "\n • Moving on to extensions, pkg managers and dev packages \n\n"

    ./os/fedora/extensions_and_pkg_managers.sh

    # restart after this
    ./os/dev_packages.sh

}

fedora_setup_final() {

    print_in_purple "\n • Final step - installing theme and apps \n\n"

    ./os/theme/main.sh

    ./os/apps.sh

    # cleanup

    sudo dnf autoremove

    print_in_purple "\n • All done! Logout and log in. Activate Pop Shell in Extensions App. \n\n"

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

}

"$@"
