##################################################################
# This script will do the following tasks on Ubuntu 12.04
# 1. Update the system packages source list
# 2. Upgrade the system packages with latest ones
# 3. Installs Vagrant
# 4. Installs Ansible
# 5. Downloads vagrantfile_rtbkit_bootstrap vagrantfile from S3
# 5. Vagrant up
##################################################################
set -o verbose
script_name="ANSIBLE_MASTER_BOOTSTRAP"
script_start_time=$(date)
echo -e "\n\n***** Executing the $script_name script *****\n\n"
echo -e "Start Time\t\t: $script_start_time"
echo -e "Executing the script as\t: $USER"
echo -e "Home directory path\t: $HOME"
###################################################################
#echo -e "\n\n***** Updating package repositories *****\n\n"
apt-get --assume-yes update
###################################################################
echo -e "\n\n***** Downloading and running install_vagrant_script *****\n\n"
rm --force install_vagrant_script.sh
rm --force install_vagrant_script.log
wget https://s3-us-west-2.amazonaws.com/rtbkit-files/shell-scripts/install_vagrant_script.sh
chmod +x install_vagrant_script.sh
./install_vagrant_script.sh 2>&1 | tee install_vagrant_script.log
###################################################################
echo -e "\n\n***** Downloading and running install_ansible_script *****\n\n"
rm --force install_ansible_script.sh
rm --force install_ansible_script.log
wget https://s3-us-west-2.amazonaws.com/rtbkit-files/shell-scripts/install_ansible_script.sh
chmod +x install_ansible_script.sh
./install_ansible_script.sh 2>&1 | tee install_ansible_script.log
###################################################################
echo -e "\n\n***** Downloading Vagrantfile to create and build RTBKit machine *****\n\n"
mkdir rtbkit_vagrant
cd rtbkit_vagrant
vagrant init
cp /vagrant/rackspace_rsa /root/.ssh/id_rsa
cp /vagrant/rackspace_rsa.pub /root/.ssh/id_rsa.pub
cp /vagrant/rackspace_rsa .
cp /vagrant/rackspace_rsa.pub .
rm --force vagrantfile_rtbkit_bootstrap
rm --force Vagrantfile
wget https://s3-us-west-2.amazonaws.com/rtbkit-files/vagrantfiles/vagrantfile_rtbkit_bootstrap
cp vagrantfile_rtbkit_bootstrap Vagrantfile
rm --force vagrantfile_rtbkit_bootstrap
###################################################################
echo -e "\n\n***** Executing the vagrant up. Log file  vagrantfile_rtbkit_bootstrap.log *****\n\n"
vagrant up --debug 2>&1 | tee vagrantfile_log.log
###################################################################
script_end_time=$(date)
echo "Script $script_name End Time: $script_end_time"
exit
###################################################################
