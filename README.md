# 🚀 Docker Install Script (Ubuntu/Debian)

This is a shell script to **automatically install the latest version of Docker** (including Docker Compose v2) on **Ubuntu/Debian-based systems**.

---

## 📌 Description

This script performs the following steps:

- Removes old Docker versions if installed.
- Installs required system dependencies.
- Adds Docker’s official GPG key and APT repository.
- Installs the latest Docker Engine, CLI, containerd, Buildx plugin, and Compose plugin.
- Enables and starts the Docker service.
- Adds the current (logged-in) user to the `docker` group so Docker can be used without `sudo`.

---

## ⚙️ Requirements

- Supported OS: Ubuntu 20.04+, Debian 10+
- `sudo` privileges on the system.

---

## 🛠️ Usage

1. Download the script:
   ```bash
   curl -O https://yourdomain.com/install_docker.sh
