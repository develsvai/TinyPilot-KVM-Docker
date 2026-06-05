# Ansible Deployment

## 선택한 방향

bastion은 Kubernetes cluster가 아니라 하드웨어 장치가 붙은 단일 Docker host로 본다.
따라서 Helm보다 Ansible + Docker Compose가 적합하다.

Ansible의 역할:

- bastion에 배포 파일 배치
- `.env` 렌더링
- Harbor TLS certificate를 Docker trust store에 설치
- Harbor registry login
- HID Gadget 준비 스크립트 실행
- `docker compose pull`
- `docker compose up -d --remove-orphans`

## 파일 구조

```text
ansible/
  ansible.cfg
  inventory.example.ini
  deploy.yml
  script/
    bastion-deploy.sh
    setup_hid_gadget.sh
  templates/
    env.j2

tools/
  ansible-runner/
    Dockerfile
```

Jenkins에서는 `tools/ansible-runner/Dockerfile`로 작은 Ansible 실행 이미지를 만들고,
배포 stage에서 해당 컨테이너 안에서 `ansible-playbook`을 실행한다.
따라서 Jenkins agent에는 `ansible-playbook`을 직접 설치하지 않아도 된다.

## 배포 입력값

Jenkins 환경 변수나 로컬 shell 환경 변수로 전달한다.

| 변수 | 설명 | 기본값 |
| --- | --- | --- |
| `DEPLOY_DIR` | bastion 배포 디렉터리 | `/home/hongyongjae/TinyPilot-KVM-Docker` |
| `HARBOR_REGISTRY` | Harbor registry 주소 | `harbor.192.168.0.110.nip.io` |
| `HARBOR_PROJECT` | Harbor project | `tinypilot` |
| `HARBOR_USER` | Harbor 사용자 | 없음 |
| `HARBOR_PASSWORD` | Harbor 비밀번호 | 없음 |
| `IMAGE_TAG` | 배포할 이미지 태그 | `latest` |
| `TAILSCALE_KEY` | Tailscale auth key | 없음 |
| `TS_HOSTNAME` | Tailscale hostname | `Tinypilot` |
| `TS_SERVE_PORT` | Tailscale serve HTTPS port | `443` |

`TAILSCALE_KEY`는 Jenkins credential `tailscale-auth-key`에서 온다.
키가 만료되거나 Tailscale에서 삭제되면 컨테이너는 `invalid key: API key does not exist`로 로그인하지 못한다.

## 수동 실행 예시

```bash
cd TinyPilot-KVM-Docker

export HARBOR_REGISTRY=harbor.192.168.0.110.nip.io
export HARBOR_PROJECT=tinypilot
export IMAGE_TAG=latest
export HARBOR_USER='...'
export HARBOR_PASSWORD='...'
export TAILSCALE_KEY='...'
export TS_HOSTNAME=Tinypilot

ansible-playbook -i ansible/inventory.example.ini ansible/deploy.yml
```

## bastion 요구사항

- Docker 설치
- `docker compose` 또는 `docker-compose` 사용 가능
- 배포 사용자가 Docker 실행 가능
- `sudo sh ansible/script/setup_hid_gadget.sh` 실행 가능
- `/dev/video0` 존재
- `/dev/net/tun` 존재
- Raspberry Pi USB Gadget 사용 가능

## Compose 실행 시 보존해야 하는 상태

TinyPilot 컨테이너:

- `/home/tinypilot/tinypilot.db`
- `/home/tinypilot/settings.yml`
- `/home/tinypilot/.flask-secret-key`

Tailscale 컨테이너:

- `/var/lib/tailscale/tailscaled.state`

이 상태를 보존하기 위해 Compose에 named volume을 둔다.
