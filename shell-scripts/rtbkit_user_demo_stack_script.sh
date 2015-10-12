#!/bin/bash
##################################################################
# Author : Swarup Donepudi
##################################################################
# Arguments : None
##################################################################
# This script will do the following tasks on Ubuntu 12.04
# 1. Start Zookeeper Server
# 2. Start Redis Server
# 3. Download the script to install Graphite server
# 4. Execute the downloaded script to install Graphite
# 5. Start Mock Exchange Runner
##################################################################
rtbkit_password="Samsungs4"
set -o verbose
script_name="RTBKit_USER_DEMO_STACK_SCRIPT"
script_start_time=$(date)
echo -e "\n\n***** Executing the $script_name script *****\n\n"
echo -e "Start Time\t\t: $script_start_time"
echo -e "Executing the script as\t: $USER"
echo -e "Home directory path\t: $HOME"
##################################################################
cd /home/rtbkit/rtbkit/rtbkit
echo -e "\n\n***** Start Zookeeper *****\n\n"
cp sample.zookeeper.conf ~/local/bin/zookeeper/conf/zoo.cfg
~/local/bin/zookeeper/bin/zkServer.sh start
echo -e "\n\n***** Started Zookeeper *****\n\n"
echo -e "\n\n***** Starting Redis *****\n\n"
rm --force sample.redis.conf
wget https://s3-us-west-2.amazonaws.com/rtbkit-files/config-files/sample.redis.conf
redis-server ./sample.redis.conf
echo -e "\n\n***** Started Redis *****\n\n"
echo -e "\n\n***** Graphite Setup begins here *****\n\n"
echo -e "\n\n***** Install Graphite *****\n\n"
cd $HOME
rm --force install_graphite_script.sh
rm --force install_graphite_script.log
wget https://s3-us-west-2.amazonaws.com/rtbkit-files/shell-scripts/install_graphite_script.sh
chmod +x install_graphite_script.sh
./install_graphite_script.sh > install_graphite_script.log 2>&1
echo -e "\n\n***** Installed Graphite. Log location install_graphite_script.log *****\n\n"
echo -e "\n\n***** Configure Graphite to record RTBKit metrics *****\n\n"
cd $HOME
rm --force sample.bootstrap.json
wget https://s3-us-west-2.amazonaws.com/rtbkit-files/rtbkit-source-files/sample.bootstrap.json
rm --force $HOME/rtbkit/rtbkit/sample.bootstrap.json
cp sample.bootstrap.json $HOME/rtbkit/rtbkit/sample.bootstrap.json
echo -e "\n\n***** Configured Graphite to record RTBKit metrics *****\n\n"
echo -e "\n\n***** Restart the carbon service *****\n\n"
echo $rtbkit_password | sudo -kS /opt/graphite/bin/carbon-cache.py stop
echo $rtbkit_password | sudo -kS /opt/graphite/bin/carbon-cache.py start
echo -e "\n\n***** Restarted the carbon service *****\n\n"
echo -e "\n\n***** Graphite setup ends here *****\n\n"
echo -e "\n\n***** Starting Mock Exchange *****\n\n"
echo -e "\n\n Navigate to /home/rtbkit/rtbkit/ directory and run the below two commands to start launcher \n\n"
echo -e "\n\n ./build/x86_64/bin/launcher --node localhost --script ./launch.sh rtbkit/sample.launch.json \n\n"
echo -e "\n\n Now run this command ./launch.sh \n\n"
cd $HOME/rtbkit
./build/x86_64/bin/mock_exchange_runner &
echo -e "\n\n***** Started Mock Exchange as a background daemon *****\n\n"
###################################################################
script_end_time=$(date)
echo -e"Script End Time: $script_end_time"
exit
###################################################################