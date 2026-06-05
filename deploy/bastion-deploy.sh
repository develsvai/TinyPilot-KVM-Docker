#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

if [ ! -f ".env" ]; then
  echo "Error: .env file is missing in $ROOT_DIR" >&2
  exit 1
fi

if command -v docker-compose >/dev/null 2>&1; then
  COMPOSE=(docker-compose)
else
  COMPOSE=(docker compose)
fi

if [ "$(id -u)" -eq 0 ]; then
  SUDO=()
else
  SUDO=(sudo)
fi

echo ">> Preparing HID gadget devices..."
"${SUDO[@]}" sh ./setup_hid_gadget.sh

echo ">> Pulling target images..."
"${COMPOSE[@]}" pull

echo ">> Applying compose deployment..."
"${COMPOSE[@]}" up -d --remove-orphans

echo ">> Deployment status..."
"${COMPOSE[@]}" ps
