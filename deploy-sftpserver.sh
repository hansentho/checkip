#!/bin/sh
## Deploy sftpserver ##
apt-get update  # To get the latest package lists
apt-get install openssh-server -y
systemctl enable ssh
systemctl start ssh

#setting up firewall
apt-get install ufw -y
ufw allow from 194.177.253.236 to any port 22 comment "tusass GW IP Address"
ufw allow from 80.83.208.0/20  to any port 22 comment "Telavox Subnets"

ufw enable

#Folders permission
mkdir /sftp/
chown -R root:root /sftp/

#Add group
addgroup sftpusers


#Add users

## Add sftpuser
useradd -s /bin/bash -d /sftp/sftpuser/ -m -G sftpusers sftpuser
chown sftpuser:sftpusers /sftp/sftpuser/
echo -e "<PASSWORD>\n<PASSWORED>" | passwd <user>
## Add tusass
useradd -s /bin/bash -d /sftp/tusass/ -m -G sftpusers tusass
chown tusass:sftpusers /sftp/tusass/
echo -e "<PASSWORD>\n<PASSWORED>" | passwd <user>

## Add telavox
useradd -s /bin/bash -d /sftp/telavox/ -m -G sftpusers telavox
chown  telavox:sftpusers /sftp/telavox/
echo -e "<PASSWORD>\n<PASSWORED>" | passwd <user>
#test