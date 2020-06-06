#!/bin/bash

# Will create 3 docker nodes for docker swarm master,worker1, worker2


ip=8

for i in master worker1 worker2;  do

ip=$((ip+1))
docker-machine create -d generic \
--generic-ssh-user vagrant \
--generic-ssh-key ~/.vagrant.d/insecure_private_key \
--generic-ip-address  192.168.199.$ip \
vm-$i

echo
echo "Creating docker host $i with ip 192.168.199.$ip"
echo

done

echo "Finished!"
echo
echo "List the docker machines:"
docker-machine ls
echo
echo "Get more info about the nodes:"
docker-machine env vm-master
docker-machine env vm-worker1
docker-machine env vm-worker2
#activating master
eval $(docker-machine env vm-master)
#init swarm
docker swarm init --advertise-addr 192.168.199.9 --listen-addr 0.0.0.0
