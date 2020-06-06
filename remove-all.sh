#!/bin/bash

docker-machine ls

for i in master worker1 worker2;  do

#ip=$((ip+1))
docker-machine rm -y vm-$i

echo
echo "Docker host $i removed"
echo

done

docker-machine ls

vagrant halt
vagrant destroy -f

rm -rf .vagrant

exit
