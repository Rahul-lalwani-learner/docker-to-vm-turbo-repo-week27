# 🐳 Docker Setup for Turborepo

This directory contains Docker configuration for the complete Turborepo application stack.

## 📦 Services

| Service | Port | Description |
|---------|------|-------------|
| **PostgreSQL** | 5432 | Database server |
| **HTTP Backend** | 3001 | REST API server |
| **WebSocket Backend** | 3002 | WebSocket server |
| **Web Frontend** | 3000 | Next.js application |

## 🚀 Quick Start

### Prerequisites
- Docker and Docker Compose installed
- Bun runtime (for local development)

### 1. **Production Setup** (Recommended)
```bash
# Start all services
docker-compose up --build -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down
```

### 2. **Development Setup** (With Environment Variables)
```bash
# Start development environment
docker-compose -f docker-compose.dev.yml --env-file .env.docker up --build

# Stop development environment
docker-compose -f docker-compose.dev.yml down
```

### 3. **Using Helper Scripts**

**Linux/Mac:**
```bash
# Make script executable
chmod +x docker-scripts.sh

# Start development
./docker-scripts.sh dev:up

# View status
./docker-scripts.sh status
```

**Windows (PowerShell):**
```powershell
# Start development
.\docker-scripts.ps1 dev:up

# View status
.\docker-scripts.ps1 status
```

## 🔧 Configuration

### Environment Variables (`.env.docker`)
```env
DATABASE_URL=postgresql://postgres:postgres123@database:5432/turborepo_db
POSTGRES_DB=turborepo_db
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres123
NODE_ENV=production
```

### Service Dependencies
```
Database → HTTP Backend
Database → WebSocket Backend  
Database → Web Frontend
HTTP Backend → Web Frontend
WebSocket Backend → Web Frontend
```

## 📋 Available Commands

### Development
- `dev:up` - Start development environment
- `dev:down` - Stop development environment
- `dev:logs` - View development logs

### Production
- `prod:up` - Start production environment
- `prod:down` - Stop production environment
- `prod:logs` - View production logs

### Database
- `db:reset` - Reset database and volumes
- `db:migrate` - Run database migrations

### Utilities
- `build` - Build all services
- `clean` - Clean up Docker resources
- `status` - Show service status

## 🗄️ Database Management

### Reset Database (Clear All Data)
```bash
docker-compose down -v
docker volume rm docker_to_vm_turborepo_postgres_data
```

### Access Database
```bash
# Connect to PostgreSQL container
docker-compose exec database psql -U postgres -d turborepo_db

# Or from host machine (if PostgreSQL client installed)
psql -h localhost -p 5432 -U postgres -d turborepo_db
```

## 🏥 Health Checks

All services include health checks:
- **Database**: `pg_isready` check
- **HTTP Backend**: HTTP GET to `/`
- **WebSocket Backend**: TCP connection test
- **Web Frontend**: HTTP GET to `/`

## 🔍 Troubleshooting

### View Service Logs
```bash
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f http-backend
docker-compose logs -f ws-backend
docker-compose logs -f web
docker-compose logs -f database
```

### Check Service Status
```bash
docker-compose ps
```

### Rebuild Services
```bash
# Rebuild all
docker-compose build --no-cache

# Rebuild specific service
docker-compose build --no-cache web
```

### Network Issues
```bash
# Check network
docker network ls
docker network inspect docker_to_vm_turborepo_turborepo-network
```

## 🚨 Common Issues

1. **Port Conflicts**: Ensure ports 3000, 3001, 3002, 5432 are available
2. **Database Connection**: Wait for database health check to pass
3. **Build Failures**: Check Dockerfile paths and dependencies
4. **Memory Issues**: Increase Docker memory allocation if needed

## 📁 File Structure
```
docker/
├── Dockerfile.backend    # HTTP Backend service
├── Dockerfile.frontend   # Web Frontend service
└── Dockerfile.ws         # WebSocket Backend service

docker-compose.yml         # Production configuration
docker-compose.dev.yml     # Development configuration
.env.docker               # Environment variables
docker-scripts.sh         # Linux/Mac helper scripts
docker-scripts.ps1        # Windows PowerShell scripts
```

## 🎯 Production Deployment

For production deployment:
1. Update `.env.docker` with production values
2. Use `docker-compose.yml` (production config)
3. Enable SSL/TLS for external access
4. Set up proper database backups
5. Configure monitoring and logging
