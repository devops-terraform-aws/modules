#!/bin/bash

# Jenkins
sudo apt update -y
sudo hostnamectl set-hostname jenkins
sudo su ubuntu
sudo apt-get install default-jdk -y
java -version
sudo apt install maven -y
mvn --version
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
echo deb http://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list
sudo apt update
sudo apt install jenkins -y