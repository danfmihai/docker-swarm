#!/bin/bash

#variablbes

VAGRANT_VERSION=2.2.9

echo "Installing... DOCKER-MACHINE"
echo
base=https://github.com/docker/machine/releases/download/v0.16.0 &&
  curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine &&
  sudo mv /tmp/docker-machine /usr/local/bin/docker-machine &&
  chmod +x /usr/local/bin/docker-machine

 chmod +x install-docker-machine.sh
if [ ! -f "vagrant_*" ]; then
  wget https://releases.hashicorp.com/vagrant/$VAGRANT_VERSION/vagrant_${VAGRANT_VERSION}_linux_amd64.zip
fi  
unzip vagra*
sudo mv vagrant /usr/local/bin
rm -rf vagrant*
vagrant halt
vagrant destroy -f
vagrant up
vagrant ssh-config
docker-machine -version

sh ./dm-vm.sh


