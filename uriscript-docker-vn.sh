#!/bin/bash
set -e

echo "==> Cập nhật hệ thống"
sudo apt-get update -y
sudo apt-get upgrade -y

echo "==> Gỡ Docker cũ (nếu có)"
sudo apt-get remove -y docker docker-engine docker.io containerd runc

echo "==> Cài gói phụ thuộc"
sudo apt-get install -y ca-certificates curl gnupg lsb-release

echo "==> Thêm GPG key và repo Docker"
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "==> Thêm repository Docker"
echo \
  "deb [arch=$(dpkg --print-architecture) \
  signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "==> Cài đặt Docker"
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "==> Kích hoạt Docker"
sudo systemctl enable docker
sudo systemctl start docker

real_user=$(logname)
echo "==> Người dùng đang đăng nhập: $real_user"
sudo usermod -aG docker $real_user

echo "==> Docker version:"
docker --version

echo "==> CÀI ĐẶT HOÀN TẤT. Vui lòng đăng xuất và đăng nhập lại."
