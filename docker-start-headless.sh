#!/bin/bash

# Docker Headless Starter for macOS
# This script starts Docker without loading the Docker Desktop GUI
# Supports multiple methods: Colima, Minikube, and Docker Desktop headless mode

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check if Docker is already running
docker_running() {
    docker info >/dev/null 2>&1
}

# Function to stop all Docker instances
stop_docker_instances() {
    print_status "Stopping any running Docker instances..."
    
    # Stop Colima if running
    if command_exists colima; then
        if colima status >/dev/null 2>&1; then
            print_status "Stopping Colima..."
            colima stop
            print_success "Colima stopped"
        fi
    fi
    
    # Stop Minikube if running
    if command_exists minikube; then
        if minikube status >/dev/null 2>&1; then
            print_status "Stopping Minikube..."
            minikube stop
            print_success "Minikube stopped"
        fi
    fi
    
    # Stop Docker Desktop if running
    if pgrep -f "Docker Desktop" >/dev/null 2>&1; then
        print_status "Stopping Docker Desktop..."
        pkill -f "Docker Desktop" || true
        # Wait a moment for graceful shutdown
        sleep 3
        print_success "Docker Desktop stopped"
    fi
    
    # Stop any remaining Docker processes
    if pgrep -f "dockerd" >/dev/null 2>&1; then
        print_status "Stopping Docker daemon..."
        pkill -f "dockerd" || true
        sleep 2
    fi
    
    print_status "All Docker instances stopped"
}

# Function to restart paused containers
restart_paused_containers() {
    print_status "Checking for paused containers..."
    
    # Get list of paused containers
    local paused_containers=$(docker ps -a --filter "status=paused" --format "{{.Names}}" 2>/dev/null || true)
    
    if [ -z "$paused_containers" ]; then
        print_status "No paused containers found"
        return 0
    fi
    
    print_status "Found paused containers: $paused_containers"
    
    # Restart each paused container
    local restarted_count=0
    local failed_count=0
    
    while IFS= read -r container_name; do
        if [ -n "$container_name" ]; then
            print_status "Restarting container: $container_name"
            if docker unpause "$container_name" >/dev/null 2>&1; then
                print_success "Restarted: $container_name"
                restarted_count=$((restarted_count + 1))
            else
                print_error "Failed to restart: $container_name"
                failed_count=$((failed_count + 1))
            fi
        fi
    done <<< "$paused_containers"
    
    if [ $restarted_count -gt 0 ]; then
        print_success "Successfully restarted $restarted_count container(s)"
    fi
    
    if [ $failed_count -gt 0 ]; then
        print_warning "Failed to restart $failed_count container(s)"
    fi
}

# Function to check and display stopped containers
check_stopped_containers() {
    print_status "Checking for stopped containers..."
    
    # Get list of stopped containers (exited status)
    local stopped_containers=$(docker ps -a --filter "status=exited" --format "{{.Names}}" 2>/dev/null || true)
    
    if [ -z "$stopped_containers" ]; then
        print_status "No stopped containers found"
        return 0
    fi
    
    print_status "Found stopped containers:"
    
    # Display stopped containers with details
    docker ps -a --filter "status=exited" --format "table {{.Names}}\t{{.Status}}\t{{.Image}}\t{{.CreatedAt}}" 2>/dev/null || true
    
    # Count stopped containers
    local stopped_count=$(echo "$stopped_containers" | wc -l | tr -d ' ')
    print_status "Total stopped containers: $stopped_count"
    
    return 0
}

# Function to restart stopped containers
restart_stopped_containers() {
    print_status "Checking for stopped containers to restart..."
    
    # Get list of stopped containers
    local stopped_containers=$(docker ps -a --filter "status=exited" --format "{{.Names}}" 2>/dev/null || true)
    
    if [ -z "$stopped_containers" ]; then
        print_status "No stopped containers found"
        return 0
    fi
    
    print_status "Found stopped containers: $stopped_containers"
    
    # Restart each stopped container
    local restarted_count=0
    local failed_count=0
    
    while IFS= read -r container_name; do
        if [ -n "$container_name" ]; then
            print_status "Restarting container: $container_name"
            if docker start "$container_name" >/dev/null 2>&1; then
                print_success "Restarted: $container_name"
                restarted_count=$((restarted_count + 1))
            else
                print_error "Failed to restart: $container_name"
                failed_count=$((failed_count + 1))
            fi
        fi
    done <<< "$stopped_containers"
    
    if [ $restarted_count -gt 0 ]; then
        print_success "Successfully restarted $restarted_count container(s)"
    fi
    
    if [ $failed_count -gt 0 ]; then
        print_warning "Failed to restart $failed_count container(s)"
    fi
}

# Function to start Docker using Colima
start_colima() {
    print_status "Starting Docker with Colima..."
    
    if ! command_exists colima; then
        print_error "Colima is not installed. Please install it with: brew install colima"
        return 1
    fi
    
    # Check if Colima is already running
    if colima status >/dev/null 2>&1; then
        print_warning "Colima is already running"
        return 0
    fi
    
    # Start Colima with optimized settings for macOS
    if [[ $(uname -m) == "arm64" ]]; then
        # Apple Silicon Mac
        colima start --cpu 4 --memory 8 --disk 20 --vm-type vz --runtime docker --save-config
    else
        # Intel Mac
        colima start --cpu 4 --memory 8 --disk 20 --vm-type qemu --runtime docker --save-config
    fi
    
    # Set Docker environment
    export DOCKER_HOST=unix://$HOME/.colima/default/docker.sock
    
    print_success "Docker started with Colima"
    print_status "Docker socket: $DOCKER_HOST"
}

# Function to start Docker using Minikube
start_minikube() {
    print_status "Starting Docker with Minikube..."
    
    if ! command_exists minikube; then
        print_error "Minikube is not installed. Please install it with: brew install minikube"
        return 1
    fi
    
    # Check if Minikube is already running
    if minikube status >/dev/null 2>&1; then
        print_warning "Minikube is already running"
        return 0
    fi
    
    # Start Minikube
    if [[ $(uname -m) == "arm64" ]]; then
        # Apple Silicon Mac
        minikube start --driver=qemu2
    else
        # Intel Mac
        minikube start --driver=qemu
    fi
    
    # Configure Docker to use Minikube's Docker daemon
    eval $(minikube docker-env)
    
    print_success "Docker started with Minikube"
}

# Function to start Docker Desktop
start_docker_desktop() {
    print_status "Starting Docker Desktop..."
    
    if ! command_exists docker; then
        print_error "Docker CLI is not installed. Please install Docker Desktop or Docker CLI"
        return 1
    fi
    
    # Check if Docker Desktop is installed
    if [[ ! -d "/Applications/Docker.app" ]]; then
        print_error "Docker Desktop is not installed"
        return 1
    fi
    
    # Check if Docker Desktop is already running
    if pgrep -f "Docker Desktop" >/dev/null 2>&1; then
        print_warning "Docker Desktop is already running"
        # Wait a moment for it to be ready
        sleep 5
        if docker_running; then
            print_success "Docker Desktop is ready"
            return 0
        fi
    fi
    
    # Start Docker Desktop (will show GUI)
    print_status "Starting Docker Desktop (GUI will appear)..."
    open -a Docker
    
    # Wait for Docker to start
    print_status "Waiting for Docker to start..."
    local max_attempts=60  # Increased timeout for Docker Desktop
    local attempt=0
    
    while ! docker_running && [ $attempt -lt $max_attempts ]; do
        sleep 2
        attempt=$((attempt + 1))
        if [ $((attempt % 10)) -eq 0 ]; then
            print_status "Attempt $attempt/$max_attempts... (Docker Desktop can take time to start)"
        fi
    done
    
    if docker_running; then
        print_success "Docker Desktop started successfully"
        print_warning "Note: Docker Desktop GUI is running. For true headless operation, consider installing Colima:"
        print_warning "  brew install colima docker"
    else
        print_error "Failed to start Docker Desktop after $max_attempts attempts"
        print_error "Docker Desktop may need manual intervention or restart"
        return 1
    fi
}

# Function to show usage
show_usage() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -c, --colima     Start Docker using Colima (recommended for headless)"
    echo "  -m, --minikube   Start Docker using Minikube"
    echo "  -d, --desktop    Start Docker Desktop (shows GUI)"
    echo "  -a, --auto       Auto-detect best available method"
    echo "  -s, --skip-stop  Skip stopping existing Docker instances"
    echo "  -r, --skip-restart Skip restarting paused containers"
    echo "  -k, --check-stopped Check and display stopped containers"
    echo "  -R, --restart-stopped Restart stopped containers"
    echo "  -h, --help       Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 --colima      # Start with Colima (true headless, recommended)"
    echo "  $0 --desktop     # Start Docker Desktop (shows GUI)"
    echo "  $0 --auto        # Auto-detect and start"
    echo "  $0 --skip-stop   # Start without stopping existing instances"
    echo "  $0 --skip-restart # Start without restarting paused containers"
    echo "  $0 --check-stopped # Check and display stopped containers"
    echo "  $0 --restart-stopped # Restart stopped containers"
    echo ""
    echo "Note: Add 'export DOCKER_HOST=unix://\$HOME/.colima/default/docker.sock' to your shell profile"
    echo "      to make Colima Docker socket persistent across terminal sessions."
}

# Function to auto-detect best method
auto_detect_method() {
    print_status "Auto-detecting best Docker method..."
    
    if command_exists colima; then
        print_status "Found Colima, using it (recommended for headless operation)"
        start_colima
    elif command_exists minikube; then
        print_status "Found Minikube, using it"
        start_minikube
    elif [[ -d "/Applications/Docker.app" ]]; then
        print_warning "Found Docker Desktop, but it will show GUI"
        print_status "For true headless operation, consider installing Colima: brew install colima docker"
        print_status "Starting Docker Desktop anyway..."
        start_docker_desktop
    else
        print_error "No Docker runtime found. Please install one of:"
        echo ""
        echo "  For headless operation (recommended):"
        echo "    brew install colima docker"
        echo ""
        echo "  Alternative options:"
        echo "    brew install minikube docker"
        echo "    Download Docker Desktop from https://docker.com"
        echo ""
        print_status "After installation, run this script again"
        return 1
    fi
}

# Main function
main() {
    local skip_stop=false
    local skip_restart=false
    
    # Parse command line arguments first to check for skip options
    for arg in "$@"; do
        case "$arg" in
            -s|--skip-stop)
                skip_stop=true
                ;;
            -r|--skip-restart)
                skip_restart=true
                ;;
        esac
    done
    
    # Stop any running Docker instances first (unless skipped)
    if [ "$skip_stop" = false ]; then
        stop_docker_instances
        # Wait a moment for cleanup
        sleep 2
    else
        print_status "Skipping Docker instance shutdown (--skip-stop specified)"
    fi
    
    # Parse command line arguments
    case "${1:-}" in
        -c|--colima)
            start_colima
            ;;
        -m|--minikube)
            start_minikube
            ;;
        -d|--desktop)
            start_docker_desktop
            ;;
        -a|--auto)
            auto_detect_method
            ;;
        -s|--skip-stop)
            # Skip-stop was already processed, now auto-detect
            auto_detect_method
            ;;
        -r|--skip-restart)
            # Skip-restart was already processed, now auto-detect
            auto_detect_method
            ;;
        -k|--check-stopped)
            check_stopped_containers
            ;;
        -R|--restart-stopped)
            restart_stopped_containers
            ;;
        -h|--help)
            show_usage
            ;;
        "")
            # No arguments provided, auto-detect
            auto_detect_method
            ;;
        *)
            print_error "Unknown option: $1"
            show_usage
            exit 1
            ;;
    esac
    
    # Test Docker functionality
    if docker_running; then
        print_status "Testing Docker functionality..."
        if docker run --rm hello-world >/dev/null 2>&1; then
            print_success "Docker is working correctly!"
        else
            print_warning "Docker started but test failed"
        fi
        
        # Restart paused containers (unless skipped)
        if [ "$skip_restart" = false ]; then
            restart_paused_containers
        else
            print_status "Skipping container restart (--skip-restart specified)"
        fi
    fi
}

# Run main function with all arguments
main "$@"
