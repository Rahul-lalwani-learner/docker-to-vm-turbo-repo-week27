# 🐳 Docker Compose Setup Summary

## 📋 What We Created

### 1. **Main Docker Compose Files**
- `docker-compose.yml` - Production configuration
- `docker-compose.dev.yml` - Development configuration with env variables
- `.env.docker` - Environment variables file

### 2. **Services Configuration**

| Service | Dockerfile | Port | Description |
|---------|------------|------|-------------|
| **database** | `postgres:15-alpine` | 5432 | PostgreSQL database |
| **http-backend** | `./docker/Dockerfile.backend` | 3001 | REST API server |
| **ws-backend** | `./docker/Dockerfile.ws` | 3002 | WebSocket server |
| **web** | `./docker/Dockerfile.frontend` | 3000 | Next.js frontend |

### 3. **Management Scripts**
- `docker-scripts.sh` - Linux/Mac management script
- `docker-scripts.ps1` - Windows PowerShell script
- `DOCKER.md` - Complete documentation

## �️ Prerequisites Setup

### **Linux (Ubuntu/Debian) - Docker Installation**

#### **1. Install Docker Engine**
```bash
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker packages:
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Verify installation:
docker compose version
```

#### **2. Fix Docker Permissions**
```bash
# Add your user to the docker group
sudo usermod -aG docker $USER

# Apply the group changes (choose one):
newgrp docker          # Apply immediately in current session
# OR logout and login again for permanent effect

# Verify Docker works without sudo:
docker --version
docker ps
```

#### **3. Start Docker Service**
```bash
# Start Docker daemon
sudo systemctl start docker

# Enable Docker to start on boot
sudo systemctl enable docker

# Check Docker status
sudo systemctl status docker
```

### **AWS Cloud Environments**

#### **AWS CloudShell (Recommended for Testing)**
```bash
# CloudShell has Docker pre-installed with proper permissions
# Access via AWS Console → CloudShell icon (terminal icon)

# Verify Docker availability:
docker --version
docker compose version
```

#### **AWS Cloud9 (For Development)**
```bash
# After creating Cloud9 environment:
sudo yum update -y
sudo yum install -y docker
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER
newgrp docker

# Install Docker Compose:
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

## �🚀 Quick Start Commands

### Start Production Environment
```bash
docker compose up --build -d
```

### Start Development Environment  
```bash
docker compose -f docker-compose.dev.yml --env-file .env.docker up --build
```

### Using Management Scripts

#### **Linux/Mac**
```bash
# Make script executable
chmod +x docker-scripts.sh

# Start development
./docker-scripts.sh dev:up

# Check status
./docker-scripts.sh status

# Stop all services
./docker-scripts.sh prod:down
```

#### **Windows PowerShell**
```powershell
# Start development
.\docker-scripts.ps1 dev:up

# Check status
.\docker-scripts.ps1 status

# Stop all services
.\docker-scripts.ps1 prod:down
```

## 🔧 Key Features

### ✅ **Health Checks**
- Database: PostgreSQL ready check
- HTTP Backend: HTTP endpoint check
- WebSocket Backend: TCP connection check  
- Web Frontend: HTTP endpoint check

### ✅ **Service Dependencies**
- Backends wait for database to be healthy
- Frontend waits for all backend services
- Proper startup order guaranteed

### ✅ **Networking**
- Custom bridge network `turborepo-network`
- Services can communicate by name
- Isolated from other Docker projects

### ✅ **Data Persistence**
- PostgreSQL data persisted in `postgres_data` volume
- Database survives container restarts

### ✅ **Environment Configuration**
- Production: Hardcoded values in `docker-compose.yml`
- Development: Environment variables from `.env.docker`
- Easy to customize for different environments

## 📊 Service Communication

```
External → Web (3000) → HTTP Backend (3001) → Database (5432)
                    → WebSocket Backend (3002) → Database (5432)
```

## 🎯 Next Steps

### **1. Setup Environment (Choose One)**

#### **Option A: Local Development**
```bash
# Install Docker (see Prerequisites above)
# Clone repository
git clone https://github.com/Rahul-lalwani-learner/docker-to-vm-turbo-repo-week27.git
cd docker-to-vm-turbo-repo-week27

# Start development environment
./docker-scripts.sh dev:up        # Linux/Mac
.\docker-scripts.ps1 dev:up       # Windows
```

#### **Option B: AWS CloudShell (No Setup Required)**
```bash
# Access AWS Console → CloudShell
git clone https://github.com/Rahul-lalwani-learner/docker-to-vm-turbo-repo-week27.git
cd docker-to-vm-turbo-repo-week27
docker compose up --build -d
```

#### **Option C: AWS Cloud9 (Full IDE)**
```bash
# Create Cloud9 environment
# Install Docker (see AWS Cloud9 setup above)
git clone https://github.com/Rahul-lalwani-learner/docker-to-vm-turbo-repo-week27.git
cd docker-to-vm-turbo-repo-week27
docker compose up --build -d
```

### **2. Access Services**
- **Web Application**: http://localhost:3000
- **HTTP API**: http://localhost:3001
- **WebSocket**: ws://localhost:3002
- **Database**: localhost:5432

### **3. Monitor and Debug**
```bash
# Check container status
docker compose ps

# View all logs
docker compose logs

# View specific service logs
docker compose logs web
docker compose logs ws-backend
docker compose logs http-backend

# Follow logs in real-time
docker compose logs -f
```

### **4. For Production Deployment**
- Update database credentials in `.env.docker`
- Use `docker-compose.yml` directly
- Set up SSL/TLS certificates
- Configure external database if needed
- Consider AWS ECS or similar container orchestration

## 🚨 Troubleshooting

### **Permission Denied Errors**
```bash
# Linux: Add user to docker group
sudo usermod -aG docker $USER
newgrp docker

# Verify permissions
docker ps
```

### **Port Already in Use**
```bash
# Check what's using the port
netstat -tulpn | grep :3000

# Stop conflicting services
docker compose down
```

### **Build Failures**
```bash
# Clean rebuild
docker compose down
docker system prune -f
docker compose up --build --force-recreate
```

Your Docker Compose setup is now ready for both development and production use! 🎉
