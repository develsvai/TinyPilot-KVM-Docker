# 트러블슈팅

차단 이슈는 없었습니다.

주의할 점:

- `task-20260701-091915-ustreamer-11167cf8` 생성 시 Job goal 연결이 약하다는 boundary warning이 있었지만, 초기 Docker Compose 스트리밍 구성 일부로 판단해 유지했습니다.
- 복원 Job/Task는 현재 CLI 기본 동작상 `PENDING` 상태입니다. 과거 완료 상태 import가 필요하면 Loom에 별도 apply/import 상태 지정 명령이 필요합니다.
