# docker-swarm
Trying to install vagrant and docker-machine so we can provision vm locally using virtualbox

First we need to create the vagrant machine (ubuntu/bionic). More details in the Vagrantfile
```
git clone https://github.com/danfmihai/docker-swarm.git
cd docker-swarm
sudo chmod x+ install-docker-machine.sh
sudo mv vagrant /usr/local/bin
sh install-docker-machine.sh
vagrant up
vagrant ssh-config
```
Test to see if you can connect to the vagrant vm. The "vagrant ssh-config" will give you the ssh connection config.

