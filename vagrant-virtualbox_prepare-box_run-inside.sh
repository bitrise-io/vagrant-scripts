#!/bin/bash

#
# Run this script inside a fresh Ubuntu install,
# inside a VirtualBox virtual machine,
# to prepare it to be distributed as a vagrant box
#

set -ex

VBOX_VER=5.1.14

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt-get install -y linux-headers-$(uname -r) build-essential dkms

sudo sh -c 'echo >> /etc/sudoers'
sudo sh -c 'echo "vagrant ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers'

# install guest additions - script: https://github.com/viktorbenei/vagrant-virtualbox-scripts/blob/master/install-vbox-guest-additions.sh
wget http://download.virtualbox.org/virtualbox/${VBOX_VER}/VBoxGuestAdditions_${VBOX_VER}.iso
sudo mkdir /media/VBoxGuestAdditions
sudo mount -o loop,ro VBoxGuestAdditions_${VBOX_VER}.iso /media/VBoxGuestAdditions
sudo sh /media/VBoxGuestAdditions/VBoxLinuxAdditions.run
rm VBoxGuestAdditions_${VBOX_VER}.iso
sudo umount /media/VBoxGuestAdditions
sudo rmdir /media/VBoxGuestAdditions

mkdir ~/.ssh
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key' >> ~/.ssh/authorized_keys

chmod 0700 ~/.ssh && chmod 0600 ~/.ssh/authorized_keys
