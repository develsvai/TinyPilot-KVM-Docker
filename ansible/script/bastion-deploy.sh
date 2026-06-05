#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$ROOT_DIR"

if [ ! -f ".env" ]; then
  echo "Error: .env file is missing in $ROOT_DIR" >&2
  exit 1
fi

if [ "$(id -u)" -eq 0 ]; then
  SUDO=()
elif sudo -n true >/dev/null 2>&1; then
  SUDO=(sudo -n)
else
  echo "Error: passwordless sudo is required for HID gadget setup." >&2
  exit 1
fi

if docker info >/dev/null 2>&1; then
  DOCKER=(docker)
elif "${SUDO[@]}" docker info >/dev/null 2>&1; then
  DOCKER=("${SUDO[@]}" docker)
else
  echo "Error: Docker is not accessible as the deployment user or through sudo." >&2
  exit 1
fi

if command -v docker-compose >/dev/null 2>&1; then
  if [ "${DOCKER[0]}" = "docker" ]; then
    COMPOSE=(docker-compose)
  else
    COMPOSE=("${SUDO[@]}" docker-compose)
  fi
else
  COMPOSE=("${DOCKER[@]}" compose)
fi

echo ">> Preparing HID gadget devices..."
"${SUDO[@]}" sh ./ansible/script/setup_hid_gadget.sh

echo ">> Pulling target images..."
"${COMPOSE[@]}" pull

echo ">> Applying compose deployment..."
"${COMPOSE[@]}" up -d --remove-orphans

echo ">> Deployment status..."
"${COMPOSE[@]}" ps
