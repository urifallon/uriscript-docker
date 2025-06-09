#!/bin/bash
set -e

# Kiểm tra chạy bằng sudo
if [ "$EUID" -ne 0 ]; then
  echo "❌ Please run this script with sudo:"
  echo "   sudo $0"
  exit 1
fi

echo "==> Updating system"
apt-get update -y
apt-get upgrade -y

echo "==> Removing old Docker versions"
apt-get remove -y docker docker.io containerd runc || true

echo "==> Installing required packages"
apt-get install -y ca-certificates curl gnupg lsb-release

echo "==> Adding Docker's GPG key"
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo "==> Adding Docker repository"
echo \
  "deb [arch=$(dpkg --print-architecture) \
  signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

echo "==> Installing Docker Engine"
apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "==> Enabling and starting Docker"
systemctl enable docker
systemctl start docker

# Gán Docker group cho user thực
real_user="${SUDO_USER:-$(whoami)}"
echo "==> Adding $real_user to docker group"
usermod -aG docker "$real_user"

echo "==> Docker version:"
docker --version

echo "✅ INSTALLATION COMPLETE."
echo "🔁 Please log out and log back in (or run 'newgrp docker') to apply Docker group permissions."
