#!/bin/bash

# Define all services
services=("api-gateway" "user-service" "discovery-server" "getter-service" "writer-service" "data-service")

for service in "${services[@]}"
do
  echo "----------------------------------------"
  echo "Building JAR and Docker image for $service..."
  echo "----------------------------------------"

  cd $service || continue

  # Step 1: Clean and build the JAR
  mvn clean package -DskipTests

  # Step 2: Build and push Docker image
  docker build -t paumicsul/$service:latest .
  docker push paumicsul/$service:latest

  cd ..
done

# Optional: redeploy with Helm (if already installed)
echo "----------------------------------------"
echo "Deploying with Helm..."
echo "----------------------------------------"
helm upgrade --install kubecrate ./helm/kubekrate \
  -f ./helm/kubekrate/values.yaml \
  -f ./helm/kubekrate/values.secret.yaml
