#!/bin/bash
echo "Installing... DOCKER-MACHINE"
echo
base=https://github.com/docker/machine/releases/download/v0.16.0 &&
  curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine &&
  sudo mv /tmp/docker-machine /usr/local/bin/docker-machine &&
  chmod +x /usr/local/bin/docker-machine

sudo chmod +x install-docker-machine.sh
if [ ! -f "vagrant_2.2.9_linux_amd64.zip" ]; then
  wget https://releases.hashicorp.com/vagrant/2.2.9/vagrant_2.2.9_linux_amd64.zip
fi  
unzip vagra*
sudo mv vagrant /usr/local/bin
vagrant halt
vagrant -f destroy
vagrant up
vagrant ssh-config
docker-machine -version
