#!/bin/bash

# Add your public SSH key to authorized_keys
#echo "${ssh_key}" >> /home/ubuntu/.ssh/authorized_keys

# Update packages and install Docker
sudo apt-get update -y
sudo apt-get install -y docker.io
