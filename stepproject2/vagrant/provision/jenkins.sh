#!/bin/bash

sudo apt update

sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install -y jenkins 
sudo apt install -y fontconfig openjdk-17-jre
sudo cat /var/lib/jenkins/secrets/initialAdminPassword


sudo apt install -y docker.io
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose


# sudo nano /etc/systemd/system/jenkins-docker.service
# sudo cat <<EOF | sudo tee /etc/systemd/system/jenkins-docker.service
# [Unit]
# Description=Jenkins Docker Container
# Requires=docker.service
# After=docker.service

# [Service]
# Restart=always
# ExecStart=/usr/bin/docker run -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts-jdk17
# ExecStop=/usr/bin/docker stop -t 2 jenkins-container
# ExecStopPost=/usr/bin/docker rm -f jenkins-container

# [Install]
# WantedBy=multi-user.target
# EOF

# sudo systemctl daemon-reload
# sudo systemctl start jenkins-docker
# sudo systemctl enable jenkins-docker


