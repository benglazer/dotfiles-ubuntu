#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Install ubuntu-dotfiles on a new server.
# Assumes nothing more than apt-get is properly installed.

# Configuration
DOTFILES_ROOT="$HOME/.dotfiles"
DOTFILES_BACKUP_DIR="$HOME/dotfiles-orig"
DOTFILES_REPO="https://github.com/benglazer/dotfiles-ubuntu.git"

install_dotfiles() {
    echo "Installing dotfiles"
    sudo apt-get install -y git stow

    echo -e "\tBacking up default dotfiles (and getting them out of stow's way)"
    mkdir -pv "$DOTFILES_BACKUP_DIR"
    mv -iv .bash_logout .bashrc .profile "$DOTFILES_BACKUP_DIR"

    echo -e "\tPulling down dotfiles repo"
    git clone "$DOTFILES_REPO" "$DOTFILES_ROOT"

    echo -e "\tInstalling dotfiles via stow"
    mkdir -pv "$DOTFILES_ROOT"
    cd "$DOTFILES_ROOT"
    stow bash git vim
}

pushd . > /dev/null

sudo apt-get update && apt-get install -y git stow "linux-headers-$(uname -r)" build-essential dkms
install_dotfiles
source "$DOTFILES_ROOT/installers/pyenv.sh"

popd > /dev/null
echo Bootstrap complete. Reboot to verify everything is working as expected.
