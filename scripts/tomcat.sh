#!/bin/bash

sudo apt update -y
sudo hostnamectl set-hostname tomcat

sudo apt-get install tomcat9 tomcat9-docs tomcat9-admin -y
sudo cp -r /usr/share/tomcat9-admin/* /var/lib/tomcat9/webapps/ -v

echo "<?xml version="1.0" encoding="UTF-8"?> \
<tomcat-users xmlns="http://tomcat.apache.org/xml" \
              xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" \
              xsi:schemaLocation="http://tomcat.apache.org/xml tomcat-users.xsd" \
              version="1.0"> \
<role rolename="manager-script"/> \
<user username="tomcat" password="password" roles="manager-script"/> \
</tomcat-users>" | sudo tee /var/lib/tomcat9/conf/tomcat-users.xml

sudo systemctl restart tomcat9
sudo systemctl status tomcat9