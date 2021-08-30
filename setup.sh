#!/bin/bash
echo "Patching the System for Initial BOOT-UP"
sleep 30
sudo apt-get update -y
sudo apt upgrade -y
echo "Installing Docker....."
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update
apt-cache policy docker-ce
sudo apt install docker-ce -y
sudo systemctl status docker
sudo usermod -aG docker ${USER}
su - ${USER}
id -nG
sudo apt install docker-compose -y
#Downloading github project
echo "!! Cloning Web application from GITHUB !!"
sudo apt install git
git --version
cd /home
sudo git clone https://github.com/sakar97/Node-JS.git
cd /home/Node-JS
sudo docker-compose up -d
