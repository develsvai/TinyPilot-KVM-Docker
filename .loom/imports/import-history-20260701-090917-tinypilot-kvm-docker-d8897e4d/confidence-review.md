# 복원 신뢰도 검토

## 요약

- draft Job: 5개
- draft Task: 16개
- evidence-map 매핑 Task: 16개
- 높은 신뢰도 Task: 12개
- 중간 신뢰도 Task: 4개
- 낮은 신뢰도 Task: 0개
- 생략 커밋: 0개

현재 draft는 apply 가능한 상태입니다. 다만 중간 신뢰도 항목은 최종 reconstruction report에 주의사항으로 남겨야 합니다.

## 높은 신뢰도의 복원 흐름

다음 흐름은 commit subject, 변경 파일, 현재 문서가 서로 잘 맞아 높은 신뢰도로 복원할 수 있습니다.

- TinyPilot/uStreamer Docker Compose 초기화
- uStreamer 해상도 옵션 조정
- 마우스 HID 디스크립터 7바이트 처리 수정
- Tailscale 컨테이너와 내부 nginx proxy 추가
- nginx ingress 비활성화와 Tailscale proxy 파일명 정리
- Ansible/Jenkins 배포 기준선 문서화와 구조 추가
- Jenkins Pipeline 실행 의존성 수정
- bastion 배포와 Harbor/arm64/runtime 문제 해결
- Tailscale auth key 보호와 HTTPS serving 수정
- legacy run script 제거와 Ansible 배포 스크립트 통합
- 사용하지 않는 원본 Dockerfile 제거
- 12자리 Git SHA immutable image tag 강제

## 중간 신뢰도의 추론 흐름

다음 항목은 근거는 있지만 일부 의도나 실제 실패 로그가 부족합니다.

- `draft-task-002` 설정 파일과 USB Gadget 구성 추가
  - `setup_hid_gadget.sh` 생성은 명확하지만 초기 `config/config.py`의 세부 역할은 diff 추가 검토가 필요합니다.
- `draft-task-006` config 위치와 이미지 경로 정리
  - config 제거 후 복구 과정의 실제 실행 실패 로그가 레포에 없습니다.
- `draft-task-008` 수동 실행용 run script 추가
  - 이후 legacy로 제거되어 실제 운영 사용 기간은 확정할 수 없습니다.
- `draft-task-009` UDC/HID 설정 검증과 README 보강
  - 현재 canonical HID setup은 `ansible/script/setup_hid_gadget.sh`이므로 과거 안정화 기록으로 남기는 것이 맞습니다.

## 생략한 커밋과 이유

생략한 커밋은 없습니다. `git-history.json` 기준 전체 31개 커밋을 5개 Job, 16개 Task 후보에 모두 매핑했습니다.

## materialize 전 수동 검토 필요 항목

필수 차단 항목은 없습니다.

권장 검토:

- `draft-task-002`, `draft-task-006`의 config 변경 의도는 커밋 diff로 더 보강할 수 있습니다.
- Jenkins 실패 원인은 실제 로그가 아니라 commit subject와 문서 기반 추론임을 보고서에 유지해야 합니다.
- Tailscale HTTPS serving은 문서와 커밋 근거는 있지만 실제 접속 검증 로그는 없습니다.

## 권장 apply 정책

- 모든 draft를 materialize해도 됩니다.
- 중간 신뢰도 항목은 최종 Job/Task 설명 또는 reconstruction report에 `중간` confidence와 evidence gap을 유지합니다.
- 새로 생성되는 과거 기록은 기존 사용자 생성 Loom Job/Task를 삭제하거나 rewrite하지 않아야 합니다.
