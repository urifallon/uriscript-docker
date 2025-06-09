#!/bin/bash
set -e

# Kiểm tra nếu không chạy bằng sudo thì cảnh báo
if [ "$EUID" -ne 0 ]; then
  echo "❌ Vui lòng chạy script này với quyền root (sudo):"
  echo "   sudo $0"
  exit 1
fi

echo "==> Cập nhật hệ thống"
apt-get update -y
apt-get upgrade -y

echo "==> Gỡ Docker cũ (nếu có)"
apt-get remove -y docker docker.io containerd runc || true

echo "==> Cài đặt các gói phụ thuộc"
apt-get install -y ca-certificates curl gnupg lsb-release

echo "==> Thêm GPG key và repository chính thức của Docker"
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo "==> Cấu hình repository Docker"
echo \
  "deb [arch=$(dpkg --print-architecture) \
  signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

echo "==> Cài đặt Docker"
apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "==> Kích hoạt và khởi động Docker"
systemctl enable docker
systemctl start docker

# Gán quyền nhóm docker cho người dùng thực
real_user="${SUDO_USER:-$(whoami)}"
echo "==> Người dùng đang đăng nhập: $real_user"
usermod -aG docker "$real_user"

echo "==> Phiên bản Docker:"
docker --version

echo "✅ CÀI ĐẶT HOÀN TẤT!"
echo "🔁 Vui lòng đăng xuất và đăng nhập lại (hoặc chạy 'newgrp docker') để áp dụng quyền nhóm Docker."
