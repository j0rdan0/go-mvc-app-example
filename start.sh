#!/bin/bash

# Cleanup all background processes on script exit
trap "kill 0" EXIT

echo "Starting development environment..."

# 1. Start RPC Service
echo "Starting RPC Service..."
(cd rpc-service && go run .) &

# Wait for RPC service to be ready (listening on 8080)
echo "Waiting for RPC service on :8080..."
until lsof -i :8080 > /dev/null 2>&1; do
  sleep 1
done
echo "RPC Service is up!"

# 2. Start Main App
echo "Starting Main Application on :3001..."
(cd app && go run .) &

# Wait for Main App to be ready (listening on 3001)
echo "Waiting for Main Application on :3001..."
until lsof -i :3001 > /dev/null 2>&1; do
  sleep 1
done
echo "Main Application is up!"

# 3. Start Dashboard
echo "Starting Dashboard..."
cd dashboard
npm run dev
