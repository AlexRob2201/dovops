#!/bin/bash

sudo apt-get update
sudo apt install -y --no-install-recommends openjdk-17-jdk-headless
sudo apt install -y docker.io
sudo adduser --group --home /home/jenkins --shell /bin/bash jenkins
sudo apt-get install -y ca-certificates curl gnupg lsb-release 
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
#curl -sO http://192.168.31.210:8080/jnlpJars/agent.jar
#java -jar agent.jar -url http://192.168.31.210:8080/ -secret c5604394d7fdccfc54bd056e00d79ac2932fa5ded9454b391b633c0cfa21e255 -name JenkinsWorker -workDir "/home/vagrant"