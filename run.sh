#!/bin/bash
set -e

echo "=== [1/2] HID Gadget Setup 실행 ==="
if [ -f "./setup_hid_gadget.sh" ]; then
    sudo sh ./setup_hid_gadget.sh
else
    echo "❌ setup_hid_gadget.sh 파일이 없습니다."
    exit 1
fi

echo "=== [2/2] Docker Compose 실행 ==="
docker-compose up -d --remove-orphans

echo "✅ 배포 완료!"
