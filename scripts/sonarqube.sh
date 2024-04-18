#!/bin/bash

version="10.4.0.87286"

sudo hostnamectl set-hostname sonar-qube
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install openjdk-17-jdk


sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
sudo wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | sudo apt-key add -
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install postgresql postgresql-contrib

sudo systemctl start postgresql
sudo systemctl enable postgresql

sudo -i -u postgres psql -c "CREATE USER sonar;"
sudo -i -u postgres psql -c "ALTER USER sonar WITH ENCRYPTED password 'password';"
sudo -i -u postgres psql -c "CREATE DATABASE sonarqube OWNER sonar;"
sudo -i -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE sonarqube to sonar;"

sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-$version.zip
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install unzip
sudo unzip sonarqube*.zip -d /opt

sudo mv /opt/sonarqube-$version /opt/sonarqube -v

sudo groupadd sonarGroup
sudo useradd -c "user to run SonarQube" -d /opt/sonarqube -g sonarGroup sonar 
sudo chown sonar:sonarGroup /opt/sonarqube -R

echo "sonar.jdbc.username=sonar \
        sonar.jdbc.password=password \
        sonar.jdbc.url=jdbc:postgresql://localhost/sonarqube" | sudo tee  /opt/sonarqube/conf/sonar.properties

sudo sed -i '1 a RUN_AS_USER=sonar' /opt/sonarqube/bin/linux-x86-64/sonar.sh

echo "[Unit]
Description=SonarQube service
After=syslog.target network.target

[Service]
Type=forking

ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start
ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop
LimitNOFILE=131072
LimitNPROC=8192
User=sonar
Group=sonarGroup
Restart=always

[Install]
WantedBy=multi-user.target" | sudo tee /etc/systemd/system/sonar.service

echo "vm.max_map_count=262144
fs.file-max=65536" | sudo tee /etc/sysctl.conf

echo "sonar   -   nofile   65536
sonar   -   nproc    4096" | sudo tee  /etc/security/limits.conf

sudo sysctl -p
sudo systemctl start sonar
sudo systemctl enable sonar
sudo systemctl status sonar