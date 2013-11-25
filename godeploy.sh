#!/bin/sh
# Script deploys ploject on localhost http://<project_name>.local
# e.g create symbolik link in apache, virtualhost config file
# Require in working directory /deploy path
# error: don't leave spaces between = in bash!

PROJECT_PATH=$(pwd)
echo "Project path is $PROJECT_PATH"
A=$(basename $PWD)
# may also be as A=`basename $PWD`
echo "Project name is $A"
echo "Reading Apache2.conf..."
echo "Please edit this file if it is not OK"
echo "========================================="
cat /etc/apache2/apache2.conf | grep IncludeOptional
echo "========================================="
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
echo "Preparing virtualhost config file..."
REPLACEMENT_KEY="project"
NEW_VALUE=$A
PATH_TO_R_CONFIG_FILE="$PWD/deploy/project.local.conf"
sudo sed -e "s/$REPLACEMENT_KEY/$NEW_VALUE/" $PATH_TO_R_CONFIG_FILE > "$PWD/deploy/$A.local.conf"
echo "New virtualhost file created succesfully"
echo "========================================="
sudo cp $PROJECT_PATH/deploy/$A.local.conf /etc/apache2/sites-available/$A.local.conf
cd /etc/apache2/sites-available
echo "========================================="
ls -la
echo "========================================="
sudo a2ensite $A.local.conf
sudo echo "127.0.0.1    $A.local" >> "/etc/hosts"
sudo service apache2 reload
firefox $A.local