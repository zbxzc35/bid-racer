#!/bin/bash
##################################################################
# Author : Swarup Donepudi
##################################################################
# Arguments : None
##################################################################
# This script will do the following tasks on Ubuntu 12.04
# 1. Install RTBKit Machine level dependencies
# 2. Update the PATH variable
##################################################################
rtbkit_password="Samsungs4"
set -o verbose
script_name="RTBKit_USER_SCRIPT_1"
script_start_time=$(date)
echo -e "\n\n***** Executing the $script_name script *****\n\n"
echo -e "Start Time\t\t: $script_start_time"
echo -e "Executing the script as\t: $USER"
echo -e "Home directory path\t: $HOME"
###################################################################
cd $HOME
echo -e "\n\n***** Installing TMUX *****\n\n"
echo $rtbkit_password | sudo -kS apt-get install --assume-yes tmux
echo -e "\n\n***** Installed TMUX *****\n\n"
echo -e "\n\n***** Installing RTBKit machine level dependencies *****\n\n"
echo $rtbkit_password | sudo -kS apt-get install --assume-yes git-core g++ libbz2-dev liblzma-dev libcrypto++-dev libpqxx3-dev scons libicu-dev strace emacs ccache make gdb time automake libtool autoconf bash-completion google-perftools libgoogle-perftools-dev valgrind libACE-dev gfortran linux-tools uuid-dev liblapack-dev libblas-dev libevent-dev flex bison pkg-config python-dev python-numpy python-numpy-dev python-matplotlib libcppunit-dev python-setuptools ant openjdk-7-jdk doxygen libfreetype6-dev libpng-dev python-tk tk-dev python-virtualenv sshfs rake ipmitool mm-common libsigc++-2.0-dev libcairo2-dev libcairomm-1.0-dev
echo $rtbkit_password | sudo -kS apt-get purge libcurl4-openssl-dev
rm  --force .profile
wget https://s3-us-west-2.amazonaws.com/rtbkit-files/unix-system-files/.profile
sh ~/.profile
###################################################################
script_end_time=$(date)
echo "Script End Time: $script_end_time"
exit
###################################################################
