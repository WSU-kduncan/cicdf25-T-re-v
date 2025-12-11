#!/bin/bash
set -e

CONTAINER_NAME="Project5"
IMAGE_NAME="spootymcspoot/project3:latest"

echo "Stopping and removing old container (if any)..."
sudo docker rm -f $CONTAINER_NAME || true

echo "Pulling latest image..."
sudo docker pull $IMAGE_NAME

echo "Starting new container..."
sudo docker run -d --name $CONTAINER_NAME -p 8000:80 --restart unless-stopped $IMAGE_NAME