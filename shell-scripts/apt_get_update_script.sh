#!/bin/bash
##################################################################
# Author : Swarup Donepudi
##################################################################
# Arguments : None
##################################################################
# This script will do the following tasks on Ubuntu 12.04
# 1. Update the system packages source list
# 2. Upgrade the system packages with latest ones
##################################################################
set -o verbose
script_name="APT-GET-UPDATE-SCRIPT"
script_start_time=$(date)
echo -e "\n\n***** Executing the $script_name script *****\n\n"
echo -e "Start Time\t\t: $script_start_time"
echo -e "Executing the script as\t: $USER"
echo -e "Home directory path\t: $HOME"
###################################################################
echo -e "\n\n***** Updating System packages source *****\n\n"
sudo apt-get --assume-yes update
echo -e "\n\n***** Updated System packages source *****\n\n"
echo -e "\n\n***** Installing latest packages *****\n\n"
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade
echo -e "\n\n***** Installed latest packages *****\n\n"
###################################################################
script_end_time=$(date)
echo "Script End Time: $script_end_time"
reboot
exit
###################################################################
