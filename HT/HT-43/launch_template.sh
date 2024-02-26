#!/bin/bash

sudo apt update -y 
sudo apt install docker.io -y
sudo apt install awscli -y

aws ecr get-login-password --region eu-central-1 | sudo docker login --username AWS --password-stdin 105742781415.dkr.ecr.eu-central-1.amazonaws.com

sudo docker pull 105742781415.dkr.ecr.eu-central-1.amazonaws.com/bukhenko-web:latest

sudo docker run -d -p 80:8000 105742781415.dkr.ecr.eu-central-1.amazonaws.com/bukhenko-web:latest 