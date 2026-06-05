# Operational Checklist

## 커밋 전

- `develop` 브랜치가 있는지 확인
- 없으면 `develop` 브랜치 생성
- 포트폴리오 문서와 `.DS_Store`를 실수로 포함하지 않기
- 배포/빌드 관련 파일만 선별 stage

추천 stage 대상:

```text
.gitignore
.env.example
ansible/
deploy/
docs/
jenkins/
docker-compose.yml
setup_hid_gadget.sh
images/tailscale/
images/tinypilot/Dockerfile.optimized
images/tinypilot/app/main.py
images/ustreamer/Dockerfile.optimized
```

루트 문서는 `README.md`만 남긴다. 과거 분석/포트폴리오 문서는
`docs/archive/`로 이동한 상태를 유지한다.

## 로컬 검증

```bash
bash -n deploy/bastion-deploy.sh
sh -n images/tailscale/start.sh

env \
  TS_HOSTNAME=Tinypilot \
  TS_AUTHKEY=dummy \
  TS_SERVE_PORT=443 \
  HARBOR_REGISTRY=harbor.192.168.0.110.nip.io \
  HARBOR_PROJECT=tinypilot \
  IMAGE_TAG=test \
  docker compose config
```

Ansible이 설치된 환경:

```bash
ansible-playbook --syntax-check -i ansible/inventory.example.ini ansible/deploy.yml
```

## Jenkins 실행 전

- Jenkins agent `docker-build-node`가 online인지 확인
- agent에서 `docker ps` 가능 여부 확인
- agent에서 `docker ps`와 `docker run` 가능 여부 확인
- Harbor credential ID 확인: `harbor-credentials`
- SSH credential ID 확인: `bastion-ssh-key`
- Tailscale credential ID 확인: `tailscale-auth-key`

## Bastion 실행 전

```bash
docker --version
docker compose version || docker-compose version
ls -l /dev/video0
ls -l /dev/net/tun
```

HID Gadget:

```bash
sudo sh ./setup_hid_gadget.sh
ls -l /dev/hidg0 /dev/hidg1
```

## 배포 후

```bash
docker ps
docker logs tinypilot --tail 100
docker logs ustreamer --tail 100
docker logs tailscale --tail 100
```

라우팅:

```bash
curl -I http://localhost:8000/
curl -I http://localhost:8001/state
```

Tailscale 경유:

```bash
curl -I http://<tailscale-host>/css/style.css
curl -I http://<tailscale-host>/third-party/socket.io/4.7.1/socket.io.min.js
curl -I http://<tailscale-host>/snapshot
curl -I http://<tailscale-host>/state
```

## 알려진 리스크

- Docker daemon이 꺼져 있으면 로컬 이미지 빌드는 검증할 수 없다.
- Tailscale auth key가 reusable이 아니면 최초 bootstrap 이후 재사용이 실패할 수 있다.
- `/dev/video0` 권한은 호스트마다 다르므로 uStreamer는 root 실행을 우선 유지한다.
- Compose `version` 경고는 최신 Compose에서 보이지만 즉시 실패 요인은 아니다.
