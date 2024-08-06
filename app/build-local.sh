#!/bin/bash

# Set the image name
IMAGE_NAME="altlayer"

# Build the Docker image
echo "Building the Docker image..."
docker build -t $IMAGE_NAME .

# Run the Docker container
echo "Running the Docker container..."
docker run -d -p 8080:8080 $IMAGE_NAME