#!/bin/bash
##################################################################
# Author : Swarup Donepudi
##################################################################
# Arguments : None
##################################################################
# This script will do the following tasks on Ubuntu 12.04
# 1. Install and configure Graphite on Ubuntu 12.04
# Note: Installation includes
#	a) Graphite dependencies installation
#	b) Carbon installtion
#	c) Whisper Installation
#	d) Graphite-Web installation
# 2. Restart apache2 server
##################################################################
rtbkit_password="Samsungs4"
set -o verbose
script_name="Graphite Installation"
script_start_time=$(date)
echo -e "\n\n***** Executing the $script_name script *****\n\n"
echo -e "Start Time\t\t: $script_start_time"
echo -e "Executing the script as\t: $USER"
echo -e "Home directory path\t: $HOME"
###################################################################
echo -e "\n\n***** Installing Graphite dependencies begins here *****\n\n"
echo $rtbkit_password | sudo -kS apt-get install --assume-yes python-cairo python-django python-django-tagging python-zope.interface fontconfig apache2 libapache2-mod-wsgi python-pysqlite2 python-simplejson git-core python-setuptools build-essential python-dev
echo $rtbkit_password | sudo -kS easy_install pip
echo $rtbkit_password | sudo -kS pip install 'Twisted<12.0'
echo -e "\n\n***** Installing Graphite dependencies ends here *****\n\n"
echo -e "\n\n***** Downloading the Git repos *****\n\n"
git clone https://github.com/graphite-project/graphite-web.git
git clone https://github.com/graphite-project/carbon.git
git clone https://github.com/graphite-project/whisper.git
echo -e "\n\n***** Downloaded the Git repos *****\n\n"
echo -e "\n\n***** Installing Whisper *****\n\n"
cd whisper/
git checkout 0.9.10
echo $rtbkit_password | sudo -kS python setup.py install
echo -e "\n\n***** Installed Whisper *****\n\n"
echo -e "\n\n***** Installing Carbon *****\n\n"
cd ../carbon/
git checkout 0.9.10
echo $rtbkit_password | sudo -kS python setup.py install
echo -e "\n\n***** Installed Carbon *****\n\n"
echo -e "\n\n***** Installing Graphite-Web *****\n\n"
cd  ../graphite-web/
git checkout 0.9.10
echo $rtbkit_password | sudo -kS python check-dependencies.py
echo $rtbkit_password | sudo -kS python setup.py install
echo -e "\n\n***** Installed Graphite-Web *****\n\n"

echo -e "\n\n***** Configuring Graphite-Web *****\n\n"

cd /opt/graphite/conf

echo $rtbkit_password | sudo -kS wget https://s3-us-west-2.amazonaws.com/rtbkit-files/config-files/carbon.conf
echo $rtbkit_password | sudo -kS cp storage-schemas.conf.example storage-schemas.conf
echo $rtbkit_password | sudo -kS wget https://s3-us-west-2.amazonaws.com/rtbkit-files/config-files/graphite.wsgi
cd /etc/apache2/sites-available/
echo $rtbkit_password | sudo -kS wget https://s3-us-west-2.amazonaws.com/rtbkit-files/config-files/graphite
cd /etc/apache2/sites-enabled/
echo $rtbkit_password | sudo -kS ln -s ../sites-available/graphite
ls -l
cd /etc/apache2/
echo $rtbkit_password | sudo -kS wget https://s3-us-west-2.amazonaws.com/rtbkit-files/config-files/graphite.htpasswd
cd ../mods-enabled/
echo $rtbkit_password | sudo -kS ls -s ../mods-available/ssl.conf
echo $rtbkit_password | sudo -kS ls -s ../mods-available/ssl.load
echo $rtbkit_password | sudo -kS a2enmod ssl
echo $rtbkit_password | sudo -kS /etc/init.d/apache2 restart
# Setup Graphite file permissions
cd /opt/graphite/webapp/graphite
echo $rtbkit_password | sudo -kS python manage.py syncdb --noinput
#--noinput option will prevent the command from prompting to create the admin user for the database
ls -l /opt/graphite/
echo $rtbkit_password | sudo -kS chown www-data /opt/graphite/storage/
cd /opt/graphite/storage/
echo $rtbkit_password | sudo -kS chown www-data:www-data graphite.db
echo $rtbkit_password | sudo -kS chown -R www-data log/
echo $rtbkit_password | sudo -kS ls -l log/ls -l log/webapp/
ls -l
#Since, rtbkit is a different user from root, set the file permissions on whisper for carbon user.
echo $rtbkit_password | sudo -kS chown -R rtbkit whisper/
echo $rtbkit_password | sudo -kS chown -R rtbkit rrd/
ls -l
echo $rtbkit_password | sudo -kS /opt/graphite/bin/carbon-cache.py start
###################################################################
script_end_time=$(date)
echo -e"Script End Time: $script_end_time"
exit
###################################################################