#!/bin/bash
##################################################################
# Author : Swarup Donepudi
##################################################################
# Arguments : None
##################################################################
# This script will do the following tasks on Ubuntu 12.04
# 1. Download Vagrant
# 2. Install dpkg
# 3. Install vagrant using dpkg
# 4. Install rackspace plugin
##################################################################
root_password=$1
set -o verbose
script_name="INSTALL_VAGRANT_SCRIPT"
script_start_time=$(date)
echo -e "\n\n***** Executing the $script_name script *****\n\n"
echo -e "Start Time\t\t: $script_start_time"
echo -e "Executing the script as\t: $USER"
echo -e "Home directory path\t: $HOME"
###################################################################
# Download Vagrant
###################################################################
wget https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.4_x86_64.deb
###################################################################
# Install dpkg
###################################################################
sudo apt-get --assume-yes install dpkg-dev
sudo  dpkg -i vagrant_1.7.4_x86_64.deb
vagrant plugin install vagrant-rackspace
###################################################################
#Vagrant installation is complete
###################################################################
script_end_time=$(date)
echo "Script $script_name End Time: $script_end_time"
exit
###################################################################
