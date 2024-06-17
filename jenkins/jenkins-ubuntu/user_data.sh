#!/bin/bash
# Update the package list
apt-get update

# Install cloud-init
apt-get install -y cloud-init

# Install fontconfig and OpenJDK 17
apt-get install -y fontconfig openjdk-17-jre

wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
apt-get update
apt-get install jenkins -y
systemctl enable jenkins
systemctl start jenkins
