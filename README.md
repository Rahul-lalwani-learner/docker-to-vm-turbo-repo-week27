# Docker Containerization & CI/CD Pipeline with Turborepo

A comprehensive DevOps project demonstrating Docker containerization, multi-service orchestration, and automated CI/CD deployment to AWS EC2.

## � DevOps Focus

This project showcases modern DevOps practices including:
- **Multi-Service Containerization**: Docker containers for each microservice
- **Intelligent CI/CD Pipeline**: Conditional builds based on code changes
- **Production Deployment**: Automated deployment to AWS EC2
- **Container Orchestration**: Docker Compose for service management
- **Infrastructure as Code**: GitHub Actions workflows for automation

## 🐳 Container Architecture

### Services & Ports
- **Database**: PostgreSQL (Port 5432)
- **HTTP Backend**: Express.js API (Port 3001)
- **WebSocket Backend**: Real-time server (Port 3002)  
- **Web Frontend**: Next.js application (Port 3000)

### Docker Configuration
- **Multi-stage builds** for optimized image sizes
- **Health checks** for service monitoring
- **Service dependencies** with proper startup order
- **Volume persistence** for database data
- **Network isolation** via Docker networks

## 📦 Project Structure

### Applications
- **`apps/web`**: Next.js frontend application
- **`apps/http-backend`**: Express.js REST API server  
- **`apps/ws-backend`**: WebSocket server for real-time communication

### Shared Packages
- **`packages/db`**: Prisma database layer with PostgreSQL
- **`packages/ui`**: Shared React component library
- **`packages/eslint-config`**: ESLint configurations
- **`packages/typescript-config`**: TypeScript configurations

## 🛠️ DevOps Technology Stack

- **Containerization**: Docker & Docker Compose
- **CI/CD**: GitHub Actions with intelligent workflows
- **Container Registry**: Docker Hub for image storage
- **Cloud Deployment**: AWS EC2 with automated provisioning
- **Orchestration**: Docker Compose for multi-service management
- **Monitoring**: Health checks and service dependency management
- **Runtime**: Bun for JavaScript execution
- **Build System**: Turborepo for monorepo optimization

## 🚀 CI/CD Pipeline Features

### 🔍 Intelligent Build System
- **Change Detection**: Only builds containers when relevant code changes
- **Path-based Triggers**: Monitors specific directories for each service
- **Dependency Awareness**: Rebuilds all services when shared packages change
- **Conditional Deployment**: Skips deployment if no changes detected

### 📋 Pipeline Stages
1. **Change Detection**: Analyze git diff to determine what changed
2. **Conditional Building**: Build only affected Docker images
3. **Image Registry**: Push to Docker Hub with latest and SHA tags
4. **AWS Deployment**: Automated deployment to EC2 instance
5. **Health Verification**: Ensure all services are healthy post-deployment

### 🔧 Deployment Automation
- **Docker Installation**: Automatic Docker/Docker Compose setup on EC2
- **Image Management**: Intelligent pulling of only updated images
- **Disk Space Management**: Automatic cleanup to prevent space issues
- **Service Orchestration**: Proper startup order with health checks
- **Zero-downtime Deployment**: Rolling updates with dependency management

## 🐳 Docker Configuration

### Multi-stage Dockerfiles
- **`docker/Dockerfile.backend`**: Optimized Express.js API container
- **`docker/Dockerfile.ws`**: WebSocket server container
- **`docker/Dockerfile.frontend`**: Next.js application container

### Docker Compose Setup
```yaml
# Production services with:
- PostgreSQL with persistent volumes
- Service health checks
- Inter-service dependencies  
- Restart policies
- Network isolation
- Environment variable management
```

## �‍♂️ Getting Started

### Prerequisites
- [Docker](https://www.docker.com/) and Docker Compose
- [Bun](https://bun.sh/) runtime
- AWS EC2 instance (for deployment)
- Docker Hub account

### Local Development with Docker

1. **Clone and setup**
   ```bash
   git clone <repository-url>
   cd docker_to_vm_turborepo
   ```

2. **Environment Configuration**
   ```env
   DATABASE_URL="postgresql://postgres:postgres123@database:5432/turborepo"
   ```

3. **Start all services**
   ```bash
   docker-compose up -d
   ```

4. **Verify deployment**
   ```bash
   docker-compose ps          # Check service status
   docker-compose logs -f     # Follow logs
   ```

### Production Deployment

1. **Configure GitHub Secrets**
   ```
   DOCKERHUB_USERNAME  # Docker Hub username
   DOCKERHUB_TOKEN     # Docker Hub access token  
   SSH_PRIVATE_KEY     # EC2 SSH private key
   ```

2. **Trigger Deployment**
   - Push to `main` branch
   - Or manually trigger via GitHub Actions

3. **Monitor Deployment**
   - Check GitHub Actions workflow status
   - Verify service health on EC2 instance

## � DevOps Commands

### Docker Operations
```bash
# Local development
docker-compose up -d              # Start all services
docker-compose down               # Stop all services
docker-compose ps                 # Check service status
docker-compose logs -f            # Follow logs

# Image management  
docker-compose build              # Build all images
docker-compose pull               # Pull latest images
docker system prune -a            # Clean up unused resources

# Individual service operations
docker-compose logs web           # Frontend logs
docker-compose logs http-backend  # API logs  
docker-compose logs ws-backend    # WebSocket logs
docker-compose logs database      # PostgreSQL logs
```

### Build System
```bash
# Turborepo commands
bun run build                     # Build all packages
bun run dev                       # Development mode
bun run lint                      # Code linting
turbo build --filter=web          # Build specific service
```

### Database Operations
```bash
bun run db:generate               # Generate Prisma client
bun run db:migrate:deploy         # Deploy migrations
```

## � Monitoring & Debugging

### Health Checks
- **HTTP Backend**: `GET /health` endpoint
- **WebSocket**: Port connectivity check
- **Database**: PostgreSQL ready check
- **Frontend**: HTTP response check

### Container Monitoring
```bash
# Service status
docker-compose ps

# Resource usage  
docker stats

# Container inspection
docker inspect <container-name>

# Logs analysis
docker-compose logs --tail=100 <service-name>
```

## 🎯 DevOps Learning Outcomes

This project demonstrates mastery of:

### 🐳 **Containerization**
- Multi-service Docker architecture
- Optimized Dockerfile creation with multi-stage builds
- Docker Compose orchestration
- Container networking and volume management
- Health check implementation

### 🔄 **CI/CD Pipeline**
- Intelligent conditional building based on code changes
- GitHub Actions workflow automation
- Docker Hub integration for image registry
- Automated AWS EC2 deployment
- Zero-downtime deployment strategies

### ☁️ **Cloud Infrastructure**
- AWS EC2 instance management
- Automated Docker installation and setup
- Production environment configuration
- Service health monitoring and restart policies

### 🛠️ **DevOps Best Practices**
- Infrastructure as Code with GitHub Actions
- Automated testing and deployment workflows
- Container resource optimization
- Service dependency management
- Monitoring and logging implementation

## 🤝 Contributing

This project showcases modern DevOps practices and container orchestration. Feel free to explore the CI/CD pipeline, Docker configurations, and deployment automation.

## 📝 License

This project is part of a DevOps learning curriculum demonstrating containerization, CI/CD, and cloud deployment practices.

---

**🚀 DevOps Project showcasing Docker, CI/CD, and AWS deployment automation**
