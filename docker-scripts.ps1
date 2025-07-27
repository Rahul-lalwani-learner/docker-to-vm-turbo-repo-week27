# Docker Compose Management Scripts for Turborepo (PowerShell)

param(
    [Parameter(Mandatory=$true)]
    [string]$Command
)

Write-Host "Docker Turborepo Management" -ForegroundColor Cyan
Write-Host "===========================" -ForegroundColor Cyan

switch ($Command.ToLower()) {
    # Development commands
    "dev:up" {
        Write-Host "Starting development environment..." -ForegroundColor Green
        docker-compose -f docker-compose.dev.yml --env-file .env.docker up --build
    }
    "dev:down" {
        Write-Host "Stopping development environment..." -ForegroundColor Yellow
        docker-compose -f docker-compose.dev.yml down
    }
    "dev:logs" {
        Write-Host "Showing development logs..." -ForegroundColor Blue
        docker-compose -f docker-compose.dev.yml logs -f
    }

    # Production commands
    "prod:up" {
        Write-Host "Starting production environment..." -ForegroundColor Green
        docker-compose up --build -d
    }
    "prod:down" {
        Write-Host "Stopping production environment..." -ForegroundColor Yellow
        docker-compose down
    }
    "prod:logs" {
        Write-Host "Showing production logs..." -ForegroundColor Blue
        docker-compose logs -f
    }

    # Database commands
    "db:reset" {
        Write-Host "Resetting database..." -ForegroundColor Magenta
        docker-compose down -v
        docker volume rm docker_to_vm_turborepo_postgres_data 2>$null
        Write-Host "Database reset complete!" -ForegroundColor Green
    }
    "db:migrate" {
        Write-Host "Running database migrations..." -ForegroundColor Magenta
        docker-compose exec http-backend bun run db:migrate
    }

    # Utility commands
    "build" {
        Write-Host "Building all services..." -ForegroundColor DarkYellow
        docker-compose build --no-cache
    }
    "clean" {
        Write-Host "Cleaning up Docker resources..." -ForegroundColor DarkRed
        docker-compose down -v --remove-orphans
        docker system prune -f
    }
    "status" {
        Write-Host "Service status:" -ForegroundColor Cyan
        docker-compose ps
    }

    default {
        Write-Host "Usage: .\docker-scripts.ps1 <command>" -ForegroundColor Red
        Write-Host ""
        Write-Host "Development Commands:" -ForegroundColor Cyan
        Write-Host "  dev:up     - Start development environment"
        Write-Host "  dev:down   - Stop development environment" 
        Write-Host "  dev:logs   - View development logs"
        Write-Host ""
        Write-Host "Production Commands:" -ForegroundColor Cyan
        Write-Host "  prod:up    - Start production environment"
        Write-Host "  prod:down  - Stop production environment"
        Write-Host "  prod:logs  - View production logs"
        Write-Host ""
        Write-Host "Database Commands:" -ForegroundColor Cyan
        Write-Host "  db:reset   - Reset database and volumes"
        Write-Host "  db:migrate - Run database migrations"
        Write-Host ""
        Write-Host "Utility Commands:" -ForegroundColor Cyan
        Write-Host "  build      - Build all services"
        Write-Host "  clean      - Clean up Docker resources"
        Write-Host "  status     - Show service status"
        exit 1
    }
}
