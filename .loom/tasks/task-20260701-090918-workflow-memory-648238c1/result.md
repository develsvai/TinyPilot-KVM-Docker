# 결과

검토된 draft를 Loom 기록으로 반영했습니다.

- 생성 Job: `5`
- 생성 Task: `16`
- 생성 provenance note: `5`
- 작성 파일:
  - `.loom/imports/import-history-20260701-090917-tinypilot-kvm-docker-d8897e4d/apply-plan.json`
  - `.loom/imports/import-history-20260701-090917-tinypilot-kvm-docker-d8897e4d/reconstruction-report.md`

검증:

- `loom status --json`: Job 6개, Task 22개
- `loom job list`: 복원 Job 5개 표시
- `loom task list --by-job --limit 10`: 복원 Task 16개 표시

남은 제약: 현재 Loom CLI에는 과거 완료 Job/Task를 원래 날짜와 DONE 상태로 materialize하는 전용 import apply 명령이 없어, 새로 생성된 복원 Job/Task는 `PENDING` 상태입니다. deprecated `loom task set-status`로 강제 완료 처리하지 않았습니다.
