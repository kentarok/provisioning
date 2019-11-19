#!/bin/bash

## set Initial Login Username & uid
UNAME=kentarok
UNAMEID=2000

## set Group & gid
GNAME=myuser
GNAMEID=1000

## Change to Japanese locale
#
#

## Change to JST time zone
#
#

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

## Enable EPEL Package
#rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

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

## Chef DK install
#rpm -Uvh https://packages.chef.io/files/stable/chefdk/2.1.11/el/7/chefdk-2.1.11-1.el7.x86_64.rpm

## Disable text passwords
sed -i.org -e "s/PasswordAuthentication yes/PasswordAuthentication no/g" /etc/ssh/sshd_config
service sshd restart
