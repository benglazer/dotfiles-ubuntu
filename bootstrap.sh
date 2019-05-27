#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

set -x  # debug

# Install ubuntu-dotfiles on a new server.
# Assumes nothing more than apt-get is properly installed.

# Configuration
DOTFILES_ROOT="${HOME}/.dotfiles"
DOTFILES_REPO="https://github.com/benglazer/dotfiles-ubuntu.git"
DOTFILES_BACKUP="${HOME}/.dotfiles-backup"
STOW_GROUPS_TO_INSTALL=(bash git vim)

backup_dotfiles() {
    echo "Backing up dotfiles"
    pushd . > /dev/null
    cd "${DOTFILES_ROOT}"
    for dotfile_group in "${STOW_GROUPS_TO_INSTALL[@]}" ; do
        cd "${dotfile_group}"
        for relative_dotfile_path in $(find . -type f) ; do
            if [[ -x "${HOME}/${relative_dotfile_path}" ]] ; then
                echo mkdir -pv "$(dirname "${DOTFILES_BACKUP}/${dotfile_group}/${relative_dotfile_path}")"
                echo mv -v "${HOME}/${relative_dotfile_path}" \
                           "${DOTFILES_BACKUP}/${dotfile_group}/${relative_dotfile_path}"
            fi
        done
        cd ..
    done
    popd > /dev/null
}

install_dotfiles() {
    echo "Installing dotfiles"
    sudo apt-get install -y git stow vim
    git clone "${DOTFILES_REPO}" "${DOTFILES_ROOT}"

    backup_dotfiles

    echo "Installing dotfiles via stow..."
    mkdir -pv "${DOTFILES_ROOT}"
    cd "${DOTFILES_ROOT}"
    stow "${STOW_GROUPS_TO_INSTALL[@]}"

    echo "Dotfiles successfully installed"
}

pushd . > /dev/null

sudo apt-get update && apt-get install -y "linux-headers-$(uname -r)" build-essential dkms
install_dotfiles
source "${DOTFILES_ROOT}/installers/pyenv.sh"

popd > /dev/null
echo Bootstrap complete. Reboot to verify everything is working as expected.
