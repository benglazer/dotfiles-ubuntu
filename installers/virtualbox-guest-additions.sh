#!/bin/bash

# Use command-line param as version number, otherwise introspect
version=$1
if [ -z "$version" ]; then
    echo "Usage: install_virtualbox_guest_additions <VIRTUALBOX_VERSION>"
    return 1
fi

echo "Installing Guest Additions for Virtualbox version '$version'"
wget http://download.virtualbox.org/virtualbox/$version/VBoxGuestAdditions_$version.iso
sudo mkdir /media/VBoxGuestAdditions
sudo mount -o loop,ro VBoxGuestAdditions_$version.iso /media/VBoxGuestAdditions
sudo sh /media/VBoxGuestAdditions/VBoxLinuxAdditions.run
sudo umount /media/VBoxGuestAdditions
sudo rmdir /media/VBoxGuestAdditions
rm VBoxGuestAdditions_$version.iso
