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
echo "<: @@ AD/A Website Start @@ >";
echo "< ==========================  >";
echo "";

echo "";
echo "Running Project Starter...";
echo "";

# Configurations :
PROJECT_NAME=ada.alonzidigital-web

# Run Project :
sudo docker start $PROJECT_NAME;
sudo docker exec $PROJECT_NAME bash -c "service apache2 start";