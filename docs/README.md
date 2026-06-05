# TinyPilot KVM Docker Docs

이 디렉터리는 오래된 프로젝트를 다시 이어서 작업하기 위한 운영 문서입니다.
루트의 포트폴리오/분석 문서는 성과 정리 성격이 강하고, 여기 문서는 실제 복구,
빌드, 배포, 라우팅 점검을 위한 기준선으로 사용합니다.

## 문서 목록

- [project-state.md](project-state.md): 현재 프로젝트 구조와 커스텀 지점
- [deployment-ansible.md](deployment-ansible.md): Ansible 기반 bastion 배포 설계
- [jenkins-migration.md](jenkins-migration.md): Jenkins item 전환 계획
- [routing-and-serving.md](routing-and-serving.md): TinyPilot/uStreamer/Tailscale 라우팅 정리
- [image-optimization-portfolio.md](image-optimization-portfolio.md): 라이브 이미지 크기와 포트폴리오용 개선 기록
- [operational-checklist.md](operational-checklist.md): 작업 전후 체크리스트
- [archive/](archive/): 이전 분석/포트폴리오 문서 보관

## 현재 방향

이 프로젝트는 Kubernetes/Helm보다 Ansible + Docker Compose가 더 적합하다.

이유:

- 실제 대상은 bastion 단일 Docker host다.
- `/dev/hidg0`, `/dev/hidg1`, `/dev/video0`, `/dev/net/tun` 같은 하드웨어 장치가 핵심이다.
- 배포에는 host-level 작업인 HID Gadget 설정이 필요하다.
- Ansible은 파일 배치, `.env` 렌더링, Harbor login, Compose 실행을 한 흐름으로 관리하기 쉽다.

## 현재 우선순위

1. 문서 기준선 정리
2. `develop` 브랜치 생성 및 변경사항 커밋
3. Jenkins `Tinypilot` item을 Git repository 기반 Pipeline으로 재구성
4. Jenkins에서 build/push/deploy 검증
5. bastion 실제 라우팅과 UI 경로 검증

## 문서 정리 원칙

- 루트에는 `README.md`만 둔다.
- 현재 운영/배포 판단은 `docs/*.md`에 둔다.
- 과거 포트폴리오, 이미지 경량화 분석, 비교표는 `docs/archive/`에 보관한다.
- 새 작업을 시작하기 전에는 [operational-checklist.md](operational-checklist.md)를 확인한다.
