#!/bin/bash
##################################################################
# Author : Swarup Donepudi
##################################################################
# Arguments : $1 - root password ( BAD IDEA )
##################################################################
# This script will do the following tasks on Ubuntu 12.04
# 1. Update the system packages source list
# 2. Upgrade the system packages with latest ones
# 3. Create a new user 'rtbkit' and assign sudo priviliges
# 4. Update the open files maximum limit to 70000 for all users
# 5. Install VSFTPD service
# 6. Install latest GCC compiler
# 7. Reboot the system
##################################################################
root_password=$1
set -o verbose
script_name="RTBKit_USER_SCRIPT_1"
script_start_time=$(date)
echo -e "\n\n***** Executing the $script_name script *****\n\n"
echo -e "Start Time\t\t: $script_start_time"
echo -e "Executing the script as\t: $USER"
echo -e "Home directory path\t: $HOME"
###################################################################
echo -e "\n\n***** Note : This shell script expects root password as 1st argument *****\n\n"
echo -e "\n\n***** Updating System packages source *****\n\n"
sudo apt-get --assume-yes update
echo -e "\n\n***** Updated System packages source *****\n\n"
echo -e "\n\n***** Installing latest packages *****\n\n"
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade
echo -e "\n\n***** Installed latest packages *****\n\n"
echo -e "\n\n***** Creating new user 'rtbkit' *****\n\n"
username="rtbkit"
password="Samsungs4"
pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
		echo $root_password | sudo -kS useradd -m -p $pass $username
		[ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"
echo -e "\n\n***** Created new user 'rtbkit' *****\n\n"
echo -e "\n\n***** Adding new user 'rtbkit' to sudo group*****\n\n"
echo $root_password | sudo -kS adduser $username sudo
echo -e "\n\n***** Added new user 'rtbkit' to sudo group*****\n\n"
echo -e "\n\n***** Resetting the maximum number of files open for all users to 70000 *****\n\n"
rm --force limits.conf
wget https://s3-us-west-2.amazonaws.com/rtbkit-files/unix-system-files/limits.conf
echo $root_password | sudo -kS rm --force /etc/security/limits.conf
echo $root_password | sudo -kS cp limits.conf /etc/security/limits.conf
echo -e "\n\n***** Finished resetting the maximum number of files open for all users to 70000 *****\n\n"
echo "\n\n***** Installing VSFTPD service *****\n\n"
rm --force vsftpd_setup_script.sh
wget https://s3-us-west-2.amazonaws.com/rtbkit-files/shell-scripts/vsftpd_setup_script.sh
chmod +x vsftpd_setup_script.sh
rm --force vsftpd_setup_script.log
./vsftpd_setup_script.sh $root_password> vsftpd_setup_script.log 2>&1
echo "\n\n***** Installed VSFTPD service *****\n\n"
echo "\n\n***** Installing GCC compiler *****\n\n"
echo $root_password | sudo -kS apt-get install --assume-yes build-essential
gcc -v
echo "\n\n***** Installed GCC compiler *****\n\n"
###################################################################
script_end_time=$(date)
echo "Script End Time: $script_end_time"
exit
###################################################################
