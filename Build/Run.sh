#!/bin/bash

echo "";
echo "< ========================== >";
echo "";
echo "           _____     __ ";
echo "     /\   |  __ \   / / ";
echo "    /  \  | |  | | / /  ";
echo "   / /\ \ | |  | |/ /  ";
echo "  / ____ \| |__| / /   ";
echo " /_/    \_\_____/_/    ";
echo "";                                                   
echo "< ==========================  >";
echo "<: @@ AD/A Website Build @@ >";
echo "< ==========================  >";
echo "";

echo "";
echo "Running Project Build...";
echo "";

# Configurations :
PROJECT_NAME=ada.alonzidigital-web
PORT=$1
PROJECT_DIR=$PWD
PROJECT_SOURCE=$PROJECT_DIR/Source/alonzidigital
CONFIG_PATH=$PROJECT_DIR/Build/Config/Sys;

# Install Docker Container :
sudo docker run -ti -d -p $PORT:80 -v $PROJECT_SOURCE:/webroot  --name  $PROJECT_NAME ubuntu;

# Let's Configure the Containers :

# Install <Apache2>
sudo docker exec $PROJECT_NAME bash -c "apt-get update";
sudo docker exec $PROJECT_NAME bash -c "DEBIAN_FRONTEND=noninteractive apt-get install apache2 -y";
sudo docker exec $PROJECT_NAME bash -c "service apache2 start";
sudo docker exec $PROJECT_NAME bash -c "apt-get update";

# Install <PHP8/MySQLPlugin>
sudo docker exec $PROJECT_NAME bash -c "DEBIAN_FRONTEND=noninteractive apt-get install lsb-release ca-certificates apt-transport-https software-properties-common -y";
sudo docker exec $PROJECT_NAME bash -c "DEBIAN_FRONTEND=noninteractive add-apt-repository ppa:ondrej/php -y";
sudo docker exec $PROJECT_NAME bash -c "apt-get update";
sudo docker exec $PROJECT_NAME bash -c "DEBIAN_FRONTEND=noninteractive apt-get install php8.2 libapache2-mod-php8.1 libapache2-mod-php8.2 -y";
sudo docker exec $PROJECT_NAME bash -c "DEBIAN_FRONTEND=noninteractive apt-get install php8.2-mysql -y";

# Copy Configuration Files to Container
sudo docker cp $CONFIG_PATH/000-default.conf $PROJECT_NAME:/etc/apache2/sites-available;
sudo docker cp $CONFIG_PATH/php.ini $PROJECT_NAME:/etc/php/8.2/apache2/;

# Enable URL ReWrite Module
sudo docker exec $PROJECT_NAME bash -c "a2enmod rewrite";

# Stop/Start Apache
sudo docker exec $PROJECT_NAME bash -c "service apache2 restart";