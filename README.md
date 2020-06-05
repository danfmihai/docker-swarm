# docker-swarm
Trying to install vagrant and docker-machine so we can provision vm locally using virtualbox

### Prerequisites
VirtualBox installed and sudo permissions

First we need to create the vagrant machine (ubuntu/bionic). More details in the Vagrantfile.
To install vagrant and run the script to install docher-machine run:
```
git clone https://github.com/danfmihai/docker-swarm.git
cd docker-swarm
sudo chmod +x install-docker-machine.sh
sudo sh install-docker-machine.sh
```

Test to see if you can connect to the vagrant vm. The "vagrant ssh-config" will give you the ssh connection config.
```
vagrant ssh-config
```
Test if docker-machine is installed
```
docker-machine -version
```
To spin up a VM use docher-machine:
```
docker-machine create -d generic \
--generic-ssh-user vagrant \
--generic-ssh-key ~/.vagrant.d/insecure_private_key \
--generic-ip-address <IP address of VM> \
<name of VM>
```
