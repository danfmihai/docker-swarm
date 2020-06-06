# docker-swarm
Trying to install vagrant and docker-machine so we can provision vm locally using virtualbox

### Prerequisites
VirtualBox installed and sudo permissions

First we need to create the vagrant machine (ubuntu/bionic). More details in the Vagrantfile.
To install vagrant and run the script to install docher-machine run:
```
git clone https://github.com/danfmihai/docker-swarm.git
cd docker-swarm
chmod +x install-docker-machine.sh
sh install-docker-machine.sh
```

Test to see if you can connect to the vagrant vm. The "vagrant ssh-config" will give you the ssh connection config.
```
vagrant ssh-config
```
Test if docker-machine is installed
```
docker-machine -version
```
To spin up a VM use docker-machine (check port no):
```
docker-machine create -d generic \
--generic-ssh-user vagrant \
--generic-ssh-key ~/.vagrant.d/insecure_private_key \
--generic-ssh-port 2222 \
--generic-ip-address <ip of vagrant VM> \
<name-of-vm>
```
Check the script for more info 'install-docker-machine.sh'

The "dm-vm.sh" script will create 3 docker nodes for docker swarm master,worker1, worker2
It will be run after the creation of the vagrant VMs called (vm-master,vm-worker1,vm-worker2)

# Add the master vm to swarm
```
#activating master
eval $(docker-machine env vm-master)
#init swarm
docker swarm init --advertise-addr 192.168.199.9 --listen-addr 0.0.0.0
```
Add worker to swarm
```
docker swarm join --token SWMTKN-1-5bo3r88omvpmt51tots4lrogxo0a4pw4v01rt7umwswbsgihdh-9i0g0v5tu8kkckbxdclopd4z9 192.168.199.9:2377
```
Get more info about nodes
```
docker node ls
docker node inspect --pretty self
```
### add a service
Ex. Add service of a web server nginx on with 3 replicas
```
docker service create --name web-server -p 8080:80 --replicas 3 nginx:latest
```
verify the service
```
docker service ls
docker service ps web-server
```
Test by draining a node to see if cluster still works
```
docker node update --availability drain docker-swarm-worker2
```
If we want to remode the node docker-swarm-worker2 we get an error. We need to leave the swarm from the vm-worker2 machine
```
docker swarm leave
```
Then remove the node from swarm on the master node
```
docker node rm docker-swarm-worker2 
docker node ls
```
Scaling the service from 3 to 6 replicas ( running on master)
```
docker service scale web-server=6
docker service ps web-server
```
If we want to update the service for example change the nginx image from latest to alpine, will update all workers
```
docker service update --image nginx:alpine web-server
docker service inspect --pretty web-server
```
Removing the service
```
docker service rm web-server
docker ps -a

```

