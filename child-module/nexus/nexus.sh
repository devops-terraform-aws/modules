#!/bin/bash

sudo yum install wget -y
sudo yum install java-1.8.0-openjdk.x86_64 -y
java -version
cd /opt
sudo wget -O nexus3.tar.gz https://download.sonatype.com/nexus/3/latest-unix.tar.gz
sudo tar -xvf nexus3.tar.gz
sudo mv nexus-3* nexus
sudo adduser nexus
sudo chown -R nexus:nexus /opt/nexus
sudo chown -R nexus:nexus /opt/sonatype-work

sudo sed -i '1 a run_as_user="nexus"' /opt/nexus/bin/nexus.rc

sudo sed -i -e 's/2703/512/g' /opt/nexus/bin/nexus.vmoptions


echo "[Unit]
Description=nexus service
After=network.target
[Service]
Type=forking
LimitNOFILE=65536
User=nexus
Group=nexus
ExecStart=/opt/nexus/bin/nexus start
ExecStop=/opt/nexus/bin/nexus stop
User=nexus
Restart=on-abort
[Install]
WantedBy=multi-user.target" | sudo tee /etc/systemd/system/nexus.service

sudo ln -s /opt/nexus/bin/nexus /etc/init.d/nexus
sudo chkconfig --add nexus
sudo chkconfig --levels 345 nexus on
sudo service nexus start
sudo service nexus status

#tail -f /opt/sonatype-work/nexus3/log/nexus.log
sudo hostnamectl set-hostname nexus
sleep 10
sudo cat /opt/sonatype-work/nexus3/admin.password