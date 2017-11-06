#!/bin/bash

# Install ubuntu-dotfiles on a new server.
# Assumes nothing more than apt-get is properly installed.

pushd . > /dev/null  # store original working dir


# Useful system variables
release_name=$(lsb_release -c | awk '{print $2}')


# Update apt
sudo apt-get update
sudo apt-get upgrade

# Ensure all dependencies are installed
sudo apt-get install -y git stow
sudo apt-get install -y "linux-headers-$(uname -r)" build-essential dkms

# Backup default dotfiles (and get them out of stow's way)
mkdir "$HOME/dotfiles-orig/"
mv -iv .bash_logout .bashrc .profile "$HOME/dotfiles-orig/"

# Pull down and install dotfiles
git clone https://github.com/benglazer/dotfiles-ubuntu.git "$HOME/.dotfiles"
cd "$HOME/.dotfiles"
stow bash git vim


popd > /dev/null  # restore original working dir
