# Project State

## 프로젝트 목적

TinyPilot을 Raspberry Pi 기반 KVM-over-IP 장비로 사용하기 위해 Docker Compose로
재구성한 프로젝트다.

주요 구성:

- TinyPilot: Flask + Socket.IO 기반 웹 UI와 HID 입력 처리
- uStreamer: `/dev/video0` 캡처 장치의 MJPEG 스트리밍
- Tailscale: Tailnet 접속과 내부 nginx reverse proxy
- Host: USB Gadget API로 `/dev/hidg0`, `/dev/hidg1` 생성

## 핵심 커스텀

### HID Gadget

[ansible/script/setup_hid_gadget.sh](../ansible/script/setup_hid_gadget.sh)가 호스트에서 USB Gadget 장치를 생성한다.

- `/dev/hidg0`: 키보드, 8바이트 리포트
- `/dev/hidg1`: 마우스, 7바이트 리포트

TinyPilot의 마우스 코드는 7바이트를 쓴다.

- byte 0: buttons
- byte 1-2: absolute X
- byte 3-4: absolute Y
- byte 5: vertical wheel
- byte 6: horizontal wheel

이 프로젝트의 마우스 디스크립터는 7바이트를 수신하되 뒤 2바이트 휠 데이터를
패딩처럼 무시하도록 조정되어 있다. 예전 우클릭 반복, 커서 고정, 마우스 먹통
문제의 핵심 해결 지점이다.

### 이미지 경량화

현재 운영 빌드에서 사용하는 Dockerfile은 최적화 버전만 남긴다.

- [images/tinypilot/Dockerfile.optimized](../images/tinypilot/Dockerfile.optimized)
- [images/ustreamer/Dockerfile.optimized](../images/ustreamer/Dockerfile.optimized)

기존 Jenkinsfile은 기본 Dockerfile만 빌드해서 최적화 파일이 실제 배포 경로에
연결되지 않았었다. 새 Jenkins 설계는 `.optimized` 파일을 명시적으로 빌드하며,
이제 단일 스테이지 원본 Dockerfile은 제거했다.

2026-06-05 bastion 라이브 이미지 기준:

- TinyPilot: 182MB
- uStreamer: 75.5MB
- Tailscale: 114MB

포트폴리오용 이전/현재 비교는
[image-optimization-portfolio.md](image-optimization-portfolio.md)에 둔다.

### Harbor 이미지

Compose는 Harbor 이미지를 pull해서 실행한다.

기본값:

- registry: `harbor.192.168.0.110.nip.io`
- project: `tinypilot`
- tag: Jenkins가 생성한 12자리 Git commit SHA

현재 Compose는 `IMAGE_TAG`가 없으면 실패하며, Ansible도 12자리 commit tag만 허용한다.

## 현재 주의할 점

- 루트 문서는 `README.md`만 유지한다.
- 과거 포트폴리오/분석 문서는 `docs/archive/`에 보관한다.
- `jenkins/`, `ansible/`, `.env.example`, 최적화 Dockerfile은 새 배포 구조의 일부다.
- `.DS_Store`, `.env`, Jenkins/Ansible 임시 파일은 `.gitignore`로 제외한다.
- 이전 로컬 시도에서 `.git` 쓰기 권한이 막혀 브랜치 생성/커밋은 권한 승인이 필요했다.
