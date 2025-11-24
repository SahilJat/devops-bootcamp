#!/bin/bash
set -e  # Stop script immediately if any command fails

# --- CONFIGURATION ---
# Change this to YOUR Docker Hub username!
IMAGE_NAME="mashidodevelop/devops-bootcamp:latest"
CONTAINER_NAME="devops-app"
PORT="8080"

echo "--- Starting Deployment for $CONTAINER_NAME ---"

# 1. Pull the latest code (Image) from the internet
echo "⬇️  Pulling latest image..."
docker pull $IMAGE_NAME

# 2. Check if a container is already running
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    echo "🛑 Stopping existing container..."
    docker stop $CONTAINER_NAME
    docker rm $CONTAINER_NAME
fi

# 3. Run the new version
echo "🚀 Starting new container..."
docker run -d \
  --name $CONTAINER_NAME \
  -p $PORT:3000 \
  $IMAGE_NAME

echo "✅ Deployment Successful! App is running on http://localhost:$PORT"
