#!/bin/bash
set -e

echo "==> Updating system"
sudo apt-get update -y
sudo apt-get upgrade -y

echo "==> Removing old Docker versions"
sudo apt-get remove -y docker docker-engine docker.io containerd runc

echo "==> Installing dependencies"
sudo apt-get install -y ca-certificates curl gnupg lsb-release

echo "==> Adding Docker GPG key and repo"
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "==> Setting up Docker repository"
echo \
  "deb [arch=$(dpkg --print-architecture) \
  signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "==> Installing Docker"
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "==> Enabling and starting Docker"
sudo systemctl enable docker
sudo systemctl start docker

real_user=$(logname)
echo "==> Current user: $real_user"
sudo usermod -aG docker $real_user

echo "==> Docker version:"
docker --version

echo "==> INSTALLATION COMPLETE. Please log out and log back in to apply Docker group membership."
