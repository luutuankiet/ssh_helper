#!/bin/bash

# just a pseudo code  might be enough. for now...

#  source env var <ip address>. others can be left to hard-code - username, port.
# TODO: make sure hard-coded value won't be published.
mkdir -p ~/utils/ssh_helper/ssh_config
source ~/utils/ssh_helper/ssh_config

# function to execute ssh:
ssh_helper() {
echo "loging in..."
sshpass -p $password ssh $username@$ip -p $port
}

# for first time config, asks for port and username (and password):
# syntax : 
# if [ <some test> ]
# then
# <commands>
# fi

if [ -z $port ] || [ -z $username ] || [ -z $password ] 
then
	dest_dir=~/utils/ssh_helper/ssh_config
	echo "config empty; please input config below:username, ip, port, password "
	read username
	read ip
	read port
	read password
  # echo each variable and append as a new line to the config
	echo "username='$username'" >> "$dest_dir"
	echo "ip=$ip" >> "$dest_dir"
	echo "port=$port" >> "$dest_dir"
	echo "password=$password" >> "$dest_dir"

else
# from 2nd time onwards
echo "saved IP config : $ip"
echo "same ip address?(y/n)"
read same_ip

fi

# happy case : same ip address > move to end of file 

# alternative case : changed ip address
if [ $name_ip = n ] 
then
echo "input new ip addr: "
new_ip=read ip
sed -i 's/ip=.*/ip=$new_ip/' $dest_dir # overwrites the previous ip
source ~/utils/ssh_helper/ssh_config.sh # re source the file
fi
ssh_helper
