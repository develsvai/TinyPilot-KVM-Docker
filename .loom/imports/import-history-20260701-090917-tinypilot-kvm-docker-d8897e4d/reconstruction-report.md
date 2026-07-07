# 재구성 리포트

- Import: `import-history-20260701-090917-tinypilot-kvm-docker-d8897e4d`
- 모드: `execute`
- Job: `5`
- Task: `16`

## Job
- `2025-06-28T23:15:38+09:00` TinyPilot Docker 기반과 HID 입력 구성 복원 `job-20250628-231538-tinypilot-docker-hid-1571c145`
- `2025-08-24T12:30:31+09:00` Tailscale 원격 접속과 nginx 프록시 라우팅 구성 `job-20250824-123031-tailscale-nginx-1de08ec4`
- `2025-08-25T03:07:38+09:00` 로컬 실행 스크립트와 HID 설정 검증 보강 `job-20250825-030738-hid-8bdb752a`
- `2026-06-05T17:18:57+09:00` Jenkins와 Ansible 기반 Harbor 배포 흐름 현대화 `job-20260605-171857-jenkins-ansible-harbor-68f2aa09`
- `2026-06-05T19:58:43+09:00` 배포 흐름 정리와 immutable image tag 강제 `job-20260605-195843-immutable-image-tag-cf3eaa93`

## Task
- `2025-06-28T23:15:38+09:00` Docker Compose 기반 TinyPilot 배포 초기화 `task-20250628-231538-docker-compose-tinypilot-3d030784`
- `2025-06-28T23:32:20+09:00` 설정 파일과 USB Gadget 구성 추가 `task-20250628-233220-usb-gadget-141f5361`
- `2025-07-11T00:26:29+09:00` uStreamer 해상도 옵션 조정 `task-20250711-002629-ustreamer-d75645a7`
- `2025-07-11T01:54:15+09:00` 마우스 HID 디스크립터 7바이트 처리 수정 `task-20250711-015415-hid-7-5eb9828f`
- `2025-08-24T12:30:31+09:00` Tailscale 컨테이너와 내부 nginx proxy 추가 `task-20250824-123031-tailscale-nginx-proxy-bf77db2a`
- `2025-08-24T12:34:31+09:00` config 위치와 이미지 경로 정리 `task-20250824-123431-config-a485622b`
- `2025-08-24T20:20:58+09:00` nginx ingress 비활성화와 Tailscale 파일명 정리 `task-20250824-202058-nginx-ingress-tailscale-d7246564`
- `2025-08-25T03:07:38+09:00` 수동 실행용 run script 추가 `task-20250825-030738-run-script-68599c5d`
- `2025-08-25T03:11:32+09:00` UDC/HID 설정 검증과 README 보강 `task-20250825-031132-udc-hid-readme-485bc9a3`
- `2026-06-05T17:18:57+09:00` Ansible/Jenkins 배포 기준선 문서화와 구조 추가 `task-20260605-171857-ansible-jenkins-114ca682`
- `2026-06-05T17:28:11+09:00` Jenkins Pipeline 실행 의존성 수정 `task-20260605-172811-jenkins-pipeline-8aed0daa`
- `2026-06-05T17:37:02+09:00` bastion 배포와 Harbor/arm64/runtime 문제 해결 `task-20260605-173702-bastion-harbor-arm64-runtime-dd681718`
- `2026-06-05T18:08:46+09:00` Tailscale auth key 보호와 HTTPS serving 수정 `task-20260605-180846-tailscale-auth-key-https-serving-fb709860`
- `2026-06-05T19:58:43+09:00` legacy run script 제거와 Ansible 배포 스크립트 통합 `task-20260605-195843-legacy-run-script-ansible-a2d35ee9`
- `2026-06-05T20:25:09+09:00` 사용하지 않는 원본 Dockerfile 제거 `task-20260605-202509-dockerfile-881fe9be`
- `2026-06-05T20:52:27+09:00` 12자리 Git SHA immutable image tag 강제 `task-20260605-205227-12-git-sha-immutable-image-tag-9e397328`
