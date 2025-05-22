#!/bin/bash

# List of your app labels (matching your deployment/service names)
services=(
  "kubekrate-api-gateway"
  "kubekrate-discovery-server"
  "kubekrate-getter-service"
  "kubekrate-writer-service"
  "kubekrate-data-service"
  "kubekrate-user-service"
)

echo "=============================="
echo "🔍 Actuator Health Checks"
echo "=============================="

for service in "${services[@]}"
do
  echo ""
  echo "👉 Checking $service..."

  pod=$(kubectl get pod -l app="$service" -o jsonpath="{.items[0].metadata.name}")
  container=$(kubectl get pod "$pod" -o jsonpath="{.spec.containers[0].name}")

  if [ -z "$pod" ]; then
    echo "❌ Pod for $service not found."
    continue
  fi

  # Run curl inside the pod to access the actuator
  status=$(kubectl exec -it "$pod" -c "$container" -- curl -s -o /dev/null -w "%{http_code}" http://localhost:$(kubectl get pod "$pod" -o jsonpath="{.spec.containers[0].ports[0].containerPort}")/actuator/health)

  if [ "$status" == "200" ]; then
    echo "✅ $service is healthy."
  else
    echo "⚠️  $service actuator returned HTTP $status"
  fi
done
