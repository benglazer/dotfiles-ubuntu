#!/bin/bash

# Install ubuntu-dotfiles on a new server.
# Assumes nothing more than apt-get is properly installed.

# Configuration
DOTFILES_ROOT="$HOME/.dotfiles"
DOTFILES_ORIG_DIR="$HOME/dotfiles-orig"
DOTFILES_REPO="https://github.com/benglazer/dotfiles-ubuntu.git"

# Store original working dir
pushd . > /dev/null

# Useful system variables
release_name=$(lsb_release -c | awk '{print $2}')


install_dotfiles() {
    sudo apt-get install -y git stow

    echo -e "\tBacking up default dotfiles (and getting them out of stow's way)"
    mkdir -pv "$DOTFILES_ORIG_DIR"
    mv -iv .bash_logout .bashrc .profile "$DOTFILES_ORIG_DIR"

    echo -e "\tPulling down dotfiles repo"
    git clone "$DOTFILES_REPO" "$DOTFILES_ROOT"

    echo -e "\tInstalling dotfiles via stow"
    mkdir -pv "$DOTFILES_ROOT"
    cd "$DOTFILES_ROOT"
    stow bash git vim
}

echo Patching mdadm.conf
grep "ARRAY devices" /etc/mdadm/mdadm.conf >/dev/null || echo "ARRAY devices=/dev/sda" | sudo -A tee -a /etc/mdadm/mdadm.conf >/dev/null;

echo Updating apt
sudo apt-get update
sudo apt-get upgrade

echo Installing dotfiles
install_dotfiles

echo Ensuring all build dependencies are installed
sudo apt-get install -y "linux-headers-$(uname -r)" build-essential dkms

echo Installing new software
source "$DOTFILES_ROOT/installers/pyenv.sh"
source "$DOTFILES_ROOT/installers/virtualbox-guest-additions.sh"

echo Restoring original working dir
popd > /dev/null

echo Bootstrap complete. You may reboot the VM to verify everything is
echo working as expected.
