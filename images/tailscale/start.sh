#!/bin/sh
set -e

# 1. Tailscale 데몬을 백그라운드에서 실행
echo "Starting tailscaled..."
tailscaled &

# tailscaled가 준비될 때까지 잠시 대기
sleep 3

# 2. 환경 변수에서 인증키와 호스트 이름 읽어서 tailscale up 실행
if [ -z ${TS_AUTHKEY} ]; then
  echo "Error: TS_AUTHKEY is not set."
  exit 1
fi

TS_HOSTNAME=${TS_HOSTNAME}

echo "Running tailscale up..."
tailscale up \
    --authkey=${TS_AUTHKEY} \
    --hostname=${TS_HOSTNAME} \
    --exit-node= \
    --accept-dns=false

# 3. Nginx를 백그라운드에서 실행
echo "Starting Nginx..."
nginx &

# Nginx가 시작될 시간을 잠시 대기
sleep 3

# 4. Tailscale의 serve 기능을 사용해 HTTPS(443) 트래픽을 내부 9090 포트로 프록시
#echo "Starting tailscale serve..."
#tailscale serve --bg --tcp 80 localhost:9090

# 5. 스크립트(컨테이너)가 종료되지 않도록 유지
echo "Setup complete. Keeping the container running..."
tail -f /dev/null
