#!/bin/bash

# Initial fedora setup

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

echo "Type in your hostname:"
read HOSTNAME
hostnamectl set-hostname $HOSTNAME

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

echo "
    Set DNF configs...
"

echo 'fastestmirror=1' | sudo tee -a /etc/dnf/dnf.conf
echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf
echo 'deltarpm=true' | sudo tee -a /etc/dnf/dnf.conf

cat /etc/dnf/dnf.conf

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

echo "
    Upgrade dnf...
"

sudo dnf upgrade --refresh
sudo dnf check
sudo dnf autoremove

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

echo "
    Update device firmwares...
"

sudo fwupdmgr get-devices
sudo fwupdmgr refresh --force
sudo fwupdmgr get-updates
sudo fwupdmgr update

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

echo "
    Install xclip for copying stuff to clipboard in scripts
"

sudo dnf install xclip

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

echo "
    Install cronie for cronjobs during setup
"

sudo dnf install cronie
