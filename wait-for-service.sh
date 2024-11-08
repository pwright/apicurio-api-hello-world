#!/bin/bash

# Target URL for the Docker Compose apicurio service endpoint
TARGET_URL="http://localhost:8080"  

# Timeout for the entire waiting process (e.g., 60 seconds)
TIMEOUT=60
INTERVAL=1  # Interval between retries

echo "Waiting for service at $TARGET_URL to be ready..."

# Countdown loop
SECONDS=0
until curl -s --head --fail "$TARGET_URL" > /dev/null; do
  if [ $SECONDS -ge $TIMEOUT ]; then
    echo "Timeout: Service at $TARGET_URL not ready after $TIMEOUT seconds." >&2
    exit 1
  fi
  echo "Service not ready, retrying in $INTERVAL seconds..."
  sleep $INTERVAL
done

echo "Service at $TARGET_URL is ready!"
