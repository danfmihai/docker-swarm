#!/bin/bash

ip=8

for i in master worker1 worker2;  do

ip=$((ip+1))
docker-machine create -d generic \
--generic-ssh-user vagrant \
--generic-ssh-key ~/.vagrant.d/insecure_private_key \
--generic-ip-address  192.168.199.$ip \
docker-swarm-$i

echo
echo "Creating docker host $i with ip 192.168.199.$ip"
echo

done

echo "Finished!"
echo "List the docker machines:"
docker-machine ls
echo
echo "Get more info about the nodes:"
docker-machine env docker-swarm-master
docker-machine env docker-swarm-worker1
docker-machine env docker-swarm-worker2