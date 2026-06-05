# TinyPilot KVM Docker

TinyPilot을 Raspberry Pi 기반 KVM-over-IP 장비로 사용하기 위해 Docker Compose로
재구성한 프로젝트입니다.

이 저장소의 핵심은 다음 세 가지입니다.

- TinyPilot 웹 UI와 HID 입력 처리를 컨테이너로 실행
- uStreamer로 `/dev/video0` 캡처 화면을 MJPEG 스트리밍
- 호스트 USB Gadget API로 `/dev/hidg0`, `/dev/hidg1`을 만들고 컨테이너에 전달

원격 접속은 Tailscale 컨테이너가 담당하며, 내부 nginx가 TinyPilot과 uStreamer로
요청을 프록시합니다.

## 현재 운영 방향

배포는 Ansible + Docker Compose로 정리합니다.

- Jenkins는 Git repository에서 Jenkinsfile을 가져와 build/push/deploy를 수행합니다.
- 이미지는 Harbor에 push합니다.
- bastion은 Ansible이 `.env`, Compose 파일, 실행 스크립트를 배치한 뒤 배포합니다.
- 하드웨어 장치 초기화는 bastion에서 `setup_hid_gadget.sh`가 담당합니다.

## 빠른 실행

수동 배포 시:

```bash
sudo sh ./setup_hid_gadget.sh
./run.sh
```

Ansible 배포 시:

```bash
ansible-playbook -i ansible/inventory.example.ini ansible/deploy.yml
```

## 주요 문서

- [docs/project-state.md](docs/project-state.md): 현재 프로젝트 구조와 커스텀 지점
- [docs/deployment-ansible.md](docs/deployment-ansible.md): Ansible 기반 bastion 배포 설계
- [docs/jenkins-migration.md](docs/jenkins-migration.md): Jenkins item 전환 계획
- [docs/routing-and-serving.md](docs/routing-and-serving.md): TinyPilot/uStreamer/Tailscale 라우팅 정리
- [docs/operational-checklist.md](docs/operational-checklist.md): 작업 전후 체크리스트
- [docs/archive/](docs/archive/): 이전 분석/포트폴리오 문서 보관

## 참고

- GitHub: https://github.com/develsvai/TinyPilot-KVM-Docker
- 관련 포스트: https://developsvai5096.tistory.com/45
