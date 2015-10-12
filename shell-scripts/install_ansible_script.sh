#!/bin/bash
##################################################################
# Author : Swarup Donepudi
##################################################################
# Arguments : None
##################################################################
# This script will do the following tasks on Ubuntu 12.04
# 1. Download Ansible
# 2. Install Ansible
##################################################################
root_password=$1
set -o verbose
script_name="INSTALL_ANSIBLE_SCRIPT"
script_start_time=$(date)
echo -e "\n\n***** Executing the $script_name script *****\n\n"
echo -e "Start Time\t\t: $script_start_time"
echo -e "Executing the script as\t: $USER"
echo -e "Home directory path\t: $HOME"
###################################################################
# Install Ansible
###################################################################
apt-get install software-properties-common
apt-add-repository ppa:ansible/ansible -y
apt-get update --assume-yes
apt-get install ansible --assume-yes
###################################################################
#Ansible installation is complete
###################################################################
script_end_time=$(date)
echo "Script $script_name End Time: $script_end_time"
exit
###################################################################
