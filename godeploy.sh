#!/bin/sh
# Script deploys ploject on localhost http://<project_name>.local
# e.g create symbolik link in apache, virtualhost config file
# Require in working directory /deploy path
# error: don't leave spaces between = in bash!

PROJECT_PATH=$(pwd)
echo "Project path is $PROJECT_PATH"
A=$(basename $PWD)
cd ..
sudo chmod -R 755 $A
# may also be as A=`basename $PWD`
echo "Project name is $A"
apache2 -v
echo "Reading main Apache2 config (/etc/apache2/apache2.conf)... Please edit this file if it is not OK"
echo "prior to 2.3.11, NameVirtualHost is required to instruct the server that a particular IP address and port combination was usable as a name-based virtual host"
echo "Directive IncludeOptional (Available in 2.3.6 and later) or Include (2.0.41 and later) must be uncomment (especially sites-enabled and mods-enabled). Grep Include in apache2.conf..."
echo "========================================="
cat /etc/apache2/apache2.conf | grep Include
echo "========================================="
echo "Manually add NameVirtualHost and IncludeOptional directive if it's needed"
echo "Would u like to edit this file? y/n"
read  ans
if [ $ans = "y" ]
	then sudo medit /etc/apache2/apache2.conf
fi
cd /var/www
sudo ln -s $PROJECT_PATH $A
echo "Symbolik link created"
echo "========================================="
ls -la
echo "========================================="
cd $PROJECT_PATH
echo "Preparing virtualhost config file, which name is $A.local.conf..."
REPLACEMENT_KEY="project"
NEW_VALUE=$A
PATH_TO_R_CONFIG_FILE="$PWD/deploy/project.local.conf"
sudo sed -e "s/$REPLACEMENT_KEY/$NEW_VALUE/" $PATH_TO_R_CONFIG_FILE > "$PWD/deploy/$A.local.conf"
echo "New virtualhost file created succesfully"
echo "========================================="
sudo cp $PROJECT_PATH/deploy/$A.local.conf /etc/apache2/sites-available/$A.local.conf
cd /etc/apache2/sites-available
sudo chmod a+rx $A.local.conf
echo "Reading /etc/apache2/sites-available catalog..."
echo "========================================="
ls -la
echo "========================================="
sudo a2ensite $A.local.conf
sudo service apache2 reload
sudo service apache2 stop
cd $PROJECT_PATH
sudo cat /etc/hosts > tmphost
echo "127.0.0.1 $A.local" >> tmphost
sudo cp tmphost /etc/hosts
rm tmphost
sudo service apache2 start
echo "If u get an error 'Could not reliably determine the server's fully qualified domain name, using 127.0.1.1 for ServerName' add to first string of /etc/hosts 127.0.0.1 localhost.localdomain localhost my-desktop"
firefox $A.local
