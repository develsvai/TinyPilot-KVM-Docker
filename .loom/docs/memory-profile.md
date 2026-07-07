# Workflow Memory Profile

Workflow memory는 사용자가 확정한 판단과 원칙을 저장합니다. 에이전트는 의미 있는 후보를
제안할 수 있지만, 사용자의 선택 없이 Memory, Job, Task로 확정하지 않습니다.

## 기본 저장소

- `principles`: 장기 제품, 아키텍처, workflow 원칙
- `decisions`: 특정 시점의 사용자 판단
- `notes`: 일반 메모
- `plans`: 계획과 다음 행동
- `troubleshooting`: 반복 가능한 실패와 복구 기록
- `runbooks`: 재사용 가능한 절차
- `reference`: 참고 문서

## Proposal lifecycle

사용자 생각 또는 에이전트 제안은 먼저 Proposal Inbox 후보가 됩니다.

```text
PROPOSED -> ACCEPTED -> MATERIALIZED -> CONSUMED
```

후보가 Job, Task, Active Memory가 되면 provenance link를 남기고 proposal을 consume합니다.

## 언어와 문서 경로

문서 제목과 내용은 workspace의 output language를 따릅니다. 기본 repository docs 경로는
`.loom/memory/profile.json`의 `docs_paths`에 정의됩니다.
