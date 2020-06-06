#!/bin/bash

# remove comment if you want to enable debugging
#set -x

username=$(id -un)
group_user=$(id -gn)

if [ -e /etc/redhat-release ] ; then
  REDHAT_BASED=true
fi

TERRAFORM_VERSION="0.12.26"
PACKER_VERSION="1.5.6"
# create new ssh key
[[ ! -f /home/$username/.ssh/mykey ]] \
&& mkdir -p /home/$username/.ssh \
&& ssh-keygen -f /home/$username/.ssh/mykey -N '' \
&& chown -R $username:$group_user /home/$username/.ssh

# install packages
if [ ${REDHAT_BASED} ] ; then
  yum -y update
  yum install -y docker ansible unzip wget
else 
  apt-get update
  apt-get -y install docker.io ansible unzip python3-pip
fi
# add docker privileges
sudo newgrp docker
sudo usermod -G docker vagrant
# install awscli and ebcli
pip3 install -U awscli
pip3 install -U awsebcli
sudo curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

#terraform
T_VERSION=$(/usr/local/bin/terraform -v | head -1 | cut -d ' ' -f 2 | tail -c +2)
T_RETVAL=${PIPESTATUS[0]}

[[ $T_VERSION != $TERRAFORM_VERSION ]] || [[ $T_RETVAL != 0 ]] \
&& wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
&& unzip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin \
&& rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# packer
P_VERSION=$(/usr/local/bin/packer -v)
P_RETVAL=$?

[[ $P_VERSION != $PACKER_VERSION ]] || [[ $P_RETVAL != 1 ]] \
&& wget -q https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip \
&& unzip -o packer_${PACKER_VERSION}_linux_amd64.zip -d /usr/local/bin \
&& rm packer_${PACKER_VERSION}_linux_amd64.zip

# clean up
if [ ! ${REDHAT_BASED} ] ; then
  apt-get clean
fi
