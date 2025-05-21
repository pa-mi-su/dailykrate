#!/bin/bash

# Define all services
services=("api-gateway" "discovery-server" "user-service" "getter-service" "writer-service" "data-service")

for service in "${services[@]}"
do
  echo "----------------------------------------"
  echo "Building and pushing $service..."
  echo "----------------------------------------"

  cd $service || continue
  docker build -t paumicsul/$service:latest .
  docker push paumicsul/$service:latest
  cd ..
done
