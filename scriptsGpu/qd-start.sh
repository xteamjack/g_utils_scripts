#!/bin/bash

# --- Configuration ---
CONTAINER_NAME="qdrant"
IMAGE_NAME="qdrant/qdrant"
REST_PORT="6333"
GRPC_PORT="6334"

# Define the absolute paths for persistent storage on the host machine
HOST_DATA_DIR="/data/v2/db/qdrant/data"
HOST_LOGS_DIR="/data/v2/db/qdrant/logs"

# IMPORTANT: Replace 'YOUR_SECRET_API_KEY' with a strong, random API key for security!
# Set this to "" to disable authentication (NOT RECOMMENDED for external access)
API_KEY="YOUR_SECRET_API_KEY"

# --- Functions ---

# Function to check and create necessary directories and set permissions
setup_directories() {
    echo "⚙️ Setting up host directories and permissions..."
    sudo mkdir -p "$HOST_DATA_DIR"
    sudo mkdir -p "$HOST_LOGS_DIR"
    
    # Change ownership to the current user to prevent permission issues
    sudo chown -R $USER:$USER "$HOST_DATA_DIR"
    sudo chown -R $USER:$USER "$HOST_LOGS_DIR"
    echo "✅ Directory setup complete."
    echo "---"
}

# Function to start the Qdrant container
start_qdrant() {
    echo "🚀 Starting Qdrant container..."
    
    # Construct the API Key environment variable argument
    API_KEY_ARG=""
    if [ ! -z "$API_KEY" ]; then
        API_KEY_ARG="-e QDRANT__SERVICE__API_KEY=$API_KEY"
        echo "🔒 API Key authentication is ENABLED."
    else
        echo "⚠️ WARNING: API Key is DISABLED. Your instance is UNSECURED."
    fi

    # Run the Docker container
    docker run -d \
      --name "$CONTAINER_NAME" \
      -p "$REST_PORT:$REST_PORT" \
      -p "$GRPC_PORT:$GRPC_PORT" \
      -v "$HOST_DATA_DIR:/qdrant/storage:z" \
      -v "$HOST_LOGS_DIR:/qdrant/logs:z" \
      $API_KEY_ARG \
      "$IMAGE_NAME"
      
    if [ $? -eq 0 ]; then
        echo "✅ Qdrant container '$CONTAINER_NAME' started successfully."
    else
        echo "❌ ERROR: Failed to start Qdrant container. Check Docker logs."
        exit 1
    fi
    echo "---"
}

# Function to display connectivity details
display_info() {
    echo "📋 Qdrant Service Details:"
    
    # Get the machine's primary IP address (requires 'ip' command, standard on Ubuntu)
    # HOST_IP=$(ip route get 1.1.1.1 | awk '/src/{print $NF; exit}')
    HOST_IP=$(ip -4 addr show | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep -v '127.0.0.1' | head -1)
    
    echo "  * Machine IP (External Access):  $HOST_IP"
    echo "  * Host Data Directory:         $HOST_DATA_DIR"
    echo "  * Host Log Directory:          $HOST_LOGS_DIR"
    echo ""
    
    echo "🌐 Connectivity URLs (Use these to test or access the service):"
    
    # Health Check URL (REST API)
    echo "  * Health Check URL:            http://$HOST_IP:$REST_PORT/healthz"
    echo "    (Test with: curl -I http://$HOST_IP:$REST_PORT/healthz)"
    
    # Dashboard URL (Web UI)
    echo "  * Web Dashboard URL:           http://$HOST_IP:$REST_PORT/dashboard"
    
    if [ ! -z "$API_KEY" ]; then
        echo ""
        echo "🔑 API Key:                     $API_KEY"
        echo "   (Required for all authenticated API calls in the 'api-key' header)"
    fi
    echo "---"
}

# --- Main Execution ---

# 1. Setup directories
setup_directories

# 2. Check if container is running
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    echo "🟢 Qdrant container '$CONTAINER_NAME' is already running."
elif [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
    # Container exists but is stopped, start it
    echo "🟡 Qdrant container '$CONTAINER_NAME' exists but is stopped. Starting it..."
    docker start "$CONTAINER_NAME"
    if [ $? -eq 0 ]; then
        echo "✅ Qdrant container started."
    else
        echo "❌ ERROR: Failed to start existing container."
        exit 1
    fi
else
    # Container does not exist, run a new one
    start_qdrant
fi

# 3. Display information
display_info

# 4. Display logs
echo "🔎 Current Live Logs (Press Ctrl+C to exit log view):"
docker logs -f "$CONTAINER_NAME"