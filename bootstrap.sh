#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Install ubuntu-dotfiles on a new server.
# Assumes nothing more than apt-get is properly installed.

# Configuration
DOTFILES_ROOT="$HOME/.dotfiles"
DOTFILES_REPO="https://github.com/benglazer/dotfiles-ubuntu.git"

install_dotfiles() {
    echo "Installing dotfiles"
    sudo apt-get install -y git stow vim
    git clone "$DOTFILES_REPO" "$DOTFILES_ROOT"

    echo "Installing dotfiles via stow..."
    mkdir -pv "$DOTFILES_ROOT"
    cd "$DOTFILES_ROOT"
    stow bash git vim

    echo "Dotfiles successfully installed"
}

pushd . > /dev/null

sudo apt-get update && apt-get install -y "linux-headers-$(uname -r)" build-essential dkms
install_dotfiles
source "$DOTFILES_ROOT/installers/pyenv.sh"

popd > /dev/null
echo Bootstrap complete. Reboot to verify everything is working as expected.
