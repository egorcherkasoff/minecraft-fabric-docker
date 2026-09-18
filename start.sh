#!/usr/bin/env bash
# Start the server: ./start.sh
set -e
cd "$(dirname "$0")"
docker compose up -d
echo ""
echo "Server is starting... Logs below (Ctrl+C closes the log view, the server keeps running)"
docker compose logs -f
