#!/bin/bash
##################################################################
# Author : Swarup Donepudi
##################################################################
# Arguments : $1 - root password ( BAD IDEA )
##################################################################
# This script will do the following tasks on Ubuntu 12.04
# 1. Install VSFTPD
# 2. Update the configuration file
###################################################################
root_password=$1
set -o verbose
script_name="VSFTPD Installation"
script_start_time=$(date)
echo -e "\n\n***** Executing the $script_name script *****\n\n"
echo -e "Start Time\t\t: $script_start_time"
echo -e "Executing the script as\t: $USER"
echo -e "Home directory path\t: $HOME"
###################################################################
cd $HOME
echo -e "\n\n***** Running the shell script to install VSFTPD Service *****\n\n"
rtbkit_password="Samsungs4"
echo $root_password | sudo -kS apt-get install vsftpd -y
rm --force vsftpd.conf
wget https://s3-us-west-2.amazonaws.com/rtbkit-files/config-files/vsftpd.conf
echo $root_password | sudo -kS cp vsftpd.conf /etc/vsftpd.conf
echo $root_password | sudo -kS service vsftpd restart
echo -e "\n\n***** Finished running the shell script to install VSFTPD Service *****\n\n"
###################################################################
script_end_time=$(date)
echo "Script End Time: $script_end_time"
exit
###################################################################