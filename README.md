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
   ```
   mkdir -p uriscript && cd uriscript && curl -O https://raw.githubusercontent.com/urifallon/uriscript-docker/main/uriscript-docker.sh
   ```

2. Make it executable and run:
   ```
   chmod +x uriscript-docker.sh
   ./uriscript-docker.sh
   ```
   
## 🇻🇳 Vietnamese Version

A Vietnamese version of this script is available [here](https://github.com/urifallon/uriscript-docker/blob/main/uriscript-docker-vn.sh), or you can run:

```bash
mkdir -p uriscript && cd uriscript && curl -O https://raw.githubusercontent.com/urifallon/uriscript-docker/main/uriscript-docker-vn.sh 
chmod +x uriscript-docker-vn.sh
./uriscript-docker-vn.sh
```
---

## 🧰 Useful Docker Commands

Here are some handy commands to get started with Docker:

### 🔎 System & Version Info
```
docker --version           # Check Docker version
docker info                # Show detailed system-wide Docker info
docker compose version     # Check Docker Compose version
```

### 🐳 Running Containers
```
docker run hello-world                     # Test Docker installation
docker run -it ubuntu bash                 # Run Ubuntu interactively
docker ps                                  # List running containers
docker ps -a                               # List all containers (including stopped)
```

### 📦 Images
```
docker images                              # List downloaded images
docker pull nginx                          # Download an image (e.g., nginx)
docker rmi <image_id>                      # Remove image
```

### 🛠️ Managing Containers
```
docker stop <container_id|name>           # Stop a running container
docker start <container_id|name>          # Start a stopped container
docker restart <container_id|name>        # Restart a container
docker rm <container_id|name>             # Remove a stopped container
```

### 📁 Volumes & Networks
```
docker volume ls                          # List volumes
docker network ls                         # List networks
```
