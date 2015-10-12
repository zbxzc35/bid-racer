#!/bin/bash
##################################################################
# Author : Swarup Donepudi
##################################################################
# Arguments : None
##################################################################
# This script will do the following tasks on Ubuntu 12.04
# 1. Install CMAKE
# 2. Install RTBKit Platform Dependencies
# 3. Compile RTBKit
# 4. Run RTBKit Test suite
# 5. Run RTBKit integration test
##################################################################
rtbkit_password="Samsungs4"
set -o verbose
script_name="RTBKit_USER_SCRIPT_2"
script_start_time=$(date)
echo -e "\n\n***** Executing the $script_name script *****\n\n"
echo -e "Start Time\t\t: $script_start_time"
echo -e "Executing the script as\t: $USER"
echo -e "Home directory path\t: $HOME"
###################################################################
env | grep PATH
echo $rtbkit_password | sudo -kS apt-get install --assume-yes cmake cmake-gui
echo -e "\n\n***** Installing RTBKit platform dependencies *****\n\n"
git clone https://github.com/datacratic/platform-deps.git
cd platform-deps
git submodule update --init
echo -e "\n\n***** Executing make all command (25 Mins Approx) *****\n\n"
make all
echo -e "\n\n***** Finished executing make all command (25 Mins Approx) *****\n\n"
echo -e "\n\n***** Installed RTBKit platform dependencies *****\n\n"
echo -e "\n\n***** Installed RTBKit platform dependencies *****\n\n"
cd $HOME
rm --force arch_testing.mk
wget https://s3-us-west-2.amazonaws.com/rtbkit-files/rtbkit-source-files/arch_testing.mk
git clone https://github.com/rtbkit/rtbkit.git
cd rtbkit
cp jml-build/sample.local.mk local.mk
rm --force $HOME/rtbkit/jml/arch/testing/arch_testing.mk
cp $HOME/arch_testing.mk $HOME/rtbkit/jml/arch/testing/arch_testing.mk
echo -e "\n\n***** Installing RTBKit dependencies *****\n\n"
make dependencies
echo -e "\n\n***** Installed RTBKit dependencies *****\n\n"
echo -e "\n\n***** Compiling RTBKit (1 hour Approx) *****\n\n"
compile_start_ime=$(date)
echo "CMake compile start Time: $compile_start_ime"
make compile
compile_end_ime=$(date)
echo "CMake compile end Time: $compile_end_time"
echo -e "\n\n***** Compiled RTBKit *****\n\n"
echo -e "\n\n***** Running RTBKit test suite *****\n\n"
make test
echo -e "\n\n***** Finished running RTBKit test suite *****\n\n"
echo -e "\n\n***** RTBKit Integration test Starting *****\n\n"
make rtbkit_integration_test
echo -e "\n\n***** RTBKit Integration test finished *****\n\n"
###################################################################
script_end_time=$(date)
echo "Script End Time: $script_end_time"
exit
###################################################################
