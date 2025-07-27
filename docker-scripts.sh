#!/bin/bash

# Docker Compose Management Scripts for Turborepo

echo "🐳 Turborepo Docker Management"
echo "==============================="

case "$1" in
  # Development commands
  "dev:up")
    echo "🚀 Starting development environment..."
    docker-compose -f docker-compose.dev.yml --env-file .env.docker up --build
    ;;
  "dev:down")
    echo "🛑 Stopping development environment..."
    docker-compose -f docker-compose.dev.yml down
    ;;
  "dev:logs")
    echo "📋 Showing development logs..."
    docker-compose -f docker-compose.dev.yml logs -f
    ;;

  # Production commands
  "prod:up")
    echo "🚀 Starting production environment..."
    docker-compose up --build -d
    ;;
  "prod:down")
    echo "🛑 Stopping production environment..."
    docker-compose down
    ;;
  "prod:logs")
    echo "📋 Showing production logs..."
    docker-compose logs -f
    ;;

  # Database commands
  "db:reset")
    echo "🗄️ Resetting database..."
    docker-compose down -v
    docker volume rm docker_to_vm_turborepo_postgres_data 2>/dev/null || true
    echo "Database reset complete!"
    ;;
  "db:migrate")
    echo "🔄 Running database migrations..."
    docker-compose exec http-backend bun run db:migrate
    ;;

  # Utility commands
  "build")
    echo "🔨 Building all services..."
    docker-compose build --no-cache
    ;;
  "clean")
    echo "🧹 Cleaning up Docker resources..."
    docker-compose down -v --remove-orphans
    docker system prune -f
    ;;
  "status")
    echo "📊 Service status:"
    docker-compose ps
    ;;

  *)
    echo "Usage: $0 {dev:up|dev:down|dev:logs|prod:up|prod:down|prod:logs|db:reset|db:migrate|build|clean|status}"
    echo ""
    echo "Development Commands:"
    echo "  dev:up     - Start development environment"
    echo "  dev:down   - Stop development environment" 
    echo "  dev:logs   - View development logs"
    echo ""
    echo "Production Commands:"
    echo "  prod:up    - Start production environment"
    echo "  prod:down  - Stop production environment"
    echo "  prod:logs  - View production logs"
    echo ""
    echo "Database Commands:"
    echo "  db:reset   - Reset database and volumes"
    echo "  db:migrate - Run database migrations"
    echo ""
    echo "Utility Commands:"
    echo "  build      - Build all services"
    echo "  clean      - Clean up Docker resources"
    echo "  status     - Show service status"
    exit 1
    ;;
esac
