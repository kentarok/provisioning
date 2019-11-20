#!/bin/bash

## set Initial Login Username & uid
UNAME=kentarok
UNAMEID=2000

## set Group & gid
GNAME=myusers
GNAMEID=1000

## Create Group
groupadd -g ${GNAMEID} ${GNAME}

## Create User
useradd -u ${UNAMEID} -g ${GNAMEID} -d /home/${UNAME} ${UNAME}
## passwd -d ${UNAME}
mkdir -p /home/${UNAME}/.ssh
chmod 755 /home/${UNAME}/.ssh
chown ${UNAME}:${GNAME} /home/${UNAME}/.ssh
cp -ip ~/.ssh/authorized_keys /home/${UNAME}/.ssh/.
chmod 600 /home/${UNAME}/.ssh/authorized_keys
chown ${UNAME}:${GNAME} /home/${UNAME}/.ssh/authorized_keys

## Edit sudoers
echo "## Allow ${GNAME} group to run any commands anywhere" >> /etc/sudoers.d/${GNAME}
echo "%${GNAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/${GNAME}

## Disable text passwords
sed -i.org -e "s/PasswordAuthentication yes/PasswordAuthentication no/g" /etc/ssh/sshd_config
service sshd restart

## install python3.5
yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install -y https://repo.ius.io/ius-release-el7.rpm
yum install -y python35u python35u-libs python35u-devel python35u-pip
ln -s /bin/pip3.5 /bin/pip3
#yum -y install yum-utils
#yum-config-manager --enable rhel-server-rhscl-7-rpms
#yum install -y rh-python36
#echo "export PATH=$PATH:/opt/rh/rh-python36/root/usr/bin/" > /etc/profile.d/path.sh
#source /etc/profile.d/path.sh

## install ansible
pip3 install ansible ansible-lint

## install ansible tower
curl -o play.yml https://raw.githubusercontent.com/kentarok/provisioning/master/ansible/play.yml 
ansible-playbook -i localhost, -c local play.yml > play.log 2>&1

## Configure Linux Firewalldyum install -y firewalld
#yum install -y firewalld
#systemctl enable firewalld.service
#systemctl start  firewalld.service
#firewall-cmd             --change-interface=eth0 --zone=trusted
#firewall-cmd --permanent --change-interface=eth0 --zone=trusted
#firewall-cmd             --change-interface=eth1 --zone=block
#firewall-cmd --permanent --change-interface=eth1 --zone=block

## Install basic tools
#yum update -y
#yum install -y git tree cifs-utils zsh telnet lsof
#yum install -y zip unzip git tree
