#!/bin/bash

declare DOT=$HOME/dotfiles

setup_cron_one() {
    # Give some time for log in after reboot
    sleep 90

    # Remove the cronjob created in setup.sh > fedora_setup_step_one (this removes all jobs)
    crontab -r

    # Setup cronjob for next reboot
    (crontab -l 2>/dev/null; echo "@reboot sh $DOT/setup/crons.sh setup_cron_two") | crontab -

    # Continue setup process
    cd $DOT && gnome-terminal -- "./setup.sh" fedora_setup_step_two
}

setup_cron_two() {
    # Give some time for log in after reboot
    sleep 90

    # Remove the cronjob created in setup_cron_one (this removes all jobs)
    crontab -r

    # Continue to final setup step
    cd $DOT && gnome-terminal -- "./setup.sh" fedora_setup_final
}

"$@"
