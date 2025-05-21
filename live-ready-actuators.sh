#!/bin/bash

services=(
  "kubekrate-api-gateway"
  "kubekrate-discovery-server"
  "kubekrate-getter-service"
  "kubekrate-writer-service"
  "kubekrate-data-service"
)

echo "=============================="
echo "🔍 Liveness & Readiness Checks"
echo "=============================="

for service in "${services[@]}"
do
  echo ""
  echo "👉 Checking $service..."

  pod=$(kubectl get pod -l app="$service" -o jsonpath="{.items[0].metadata.name}")
  if [ -z "$pod" ]; then
    echo "❌ Pod for $service not found."
    continue
  fi

  container=$(kubectl get pod "$pod" -o jsonpath="{.spec.containers[0].name}")
  port=$(kubectl get pod "$pod" -o jsonpath="{.spec.containers[0].ports[0].containerPort}")

  echo "📦 $service ($pod on port $port)"

  echo "  🔹 Liveness:"
  kubectl exec -it "$pod" -c "$container" -- curl -s -o /dev/null -w "HTTP %{http_code}\n" http://localhost:$port/actuator/health/liveness || echo "    ❌ curl failed"

  echo "  🔹 Readiness:"
  kubectl exec -it "$pod" -c "$container" -- curl -s -o /dev/null -w "HTTP %{http_code}\n" http://localhost:$port/actuator/health/readiness || echo "    ❌ curl failed"
done
