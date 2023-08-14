#!/bin/bash

sudo hostnamectl set-hostname jenkins
sudo su - ubuntu
sudo apt update -y
sudo apt-get install default-jdk -y
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update -y
sudo apt-get install jenkins -y
echo "Your password is below"
sleep 15
sudo cat /var/lib/jenkins/secrets/initialAdminPassword


############# install terraform #################
sudo apt-get update && sudo apt-get install -y curl unzip jq
TERRAFORM_VERSION=$(curl -s https://checkpoint-api.hashicorp.com/v1/check/terraform | jq -r -M '.current_version')
curl -o /tmp/terraform.zip -LO "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip"
sudo unzip /tmp/terraform.zip -d /usr/local/bin/
sudo chmod +x /usr/local/bin/terraform


################ tfsec ##########################
curl -s https://raw.githubusercontent.com/aquasecurity/tfsec/master/scripts/install_linux.sh | bash