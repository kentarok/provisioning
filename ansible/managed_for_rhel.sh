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
