#!/bin/bash

# Install ubuntu-dotfiles on a new server.
# Assumes nothing more than apt-get is properly installed.

pushd . > /dev/null  # store original working dir


# Useful system variables
release_name=$(lsb_release -c | awk '{print $2}')

echo Updating apt
sudo apt-get update
sudo apt-get upgrade

echo Ensuring all build dependencies are installed
sudo apt-get install -y "linux-headers-$(uname -r)" build-essential dkms
sudo apt-get install -y git stow

echo "Backing up default dotfiles (and getting them out of stow's way)"
mkdir "$HOME/dotfiles-orig/"
mv -iv .bash_logout .bashrc .profile "$HOME/dotfiles-orig/"

echo Pulling down dotfiles repo
git clone https://github.com/benglazer/dotfiles-ubuntu.git "$HOME/.dotfiles"

echo Installing dotfiles via stow
cd "$HOME/.dotfiles"
stow bash git vim


popd > /dev/null  # restore original working dir
