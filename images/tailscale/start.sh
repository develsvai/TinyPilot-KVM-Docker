#!/bin/sh
set -e

TS_HOSTNAME="${TS_HOSTNAME:-tinypilot}"
TS_SERVE_PORT="${TS_SERVE_PORT:-80}"
TAILSCALE_STATE_DIR="/var/lib/tailscale"
TAILSCALE_STATE_FILE="${TAILSCALE_STATE_DIR}/tailscaled.state"

mkdir -p "${TAILSCALE_STATE_DIR}"

# 1. Tailscale 데몬을 백그라운드에서 실행
echo "Starting tailscaled..."
tailscaled --state="${TAILSCALE_STATE_FILE}" &

# tailscaled가 준비될 때까지 잠시 대기
sleep 3

# 2. 환경 변수에서 인증키와 호스트 이름 읽어서 tailscale up 실행

echo "Running tailscale up..."
if [ -n "${TS_AUTHKEY:-}" ]; then
  tailscale up \
      --authkey="${TS_AUTHKEY}" \
      --hostname="${TS_HOSTNAME}" \
      --exit-node= \
      --accept-dns=false
else
  tailscale up \
      --hostname="${TS_HOSTNAME}" \
      --exit-node= \
      --accept-dns=false
fi

# 3. Nginx를 백그라운드에서 실행
echo "Starting Nginx..."
nginx &

# Nginx가 시작될 시간을 잠시 대기
sleep 3

# 4. Tailscale serve 기능으로 Tailnet TCP 트래픽을 내부 9090 포트로 프록시
echo "Starting tailscale serve..."
tailscale serve --bg --tcp "${TS_SERVE_PORT}" localhost:9090

# 5. 스크립트(컨테이너)가 종료되지 않도록 유지
echo "Setup complete. Keeping the container running..."
tail -f /dev/null
