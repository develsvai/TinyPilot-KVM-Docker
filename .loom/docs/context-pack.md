# Task Context Pack Contract

Task 실행 전 에이전트가 읽어야 하는 기본 입력은 아래 세 파일입니다.

- `prompt.md`
- `context.md`
- `previous-results.md`

## 자동 포함

`TaskContextBuilder`는 아래 항목만 자동 포함합니다.

- `.loom/project.md`의 project memory
- 현재 Job과 Task의 계약 metadata
- 현재 Job의 `notes.md`
- 현재 Job에 명시된 `context_refs`
- Task에 명시된 `required_docs`
- Task에 명시된 `.loom/memory` 기반 `memory_refs`
- 상태가 `ACTIVE`인 workflow memory
- 같은 Job에서 현재 Task보다 앞선 Task 중 결과가 기록된 최근 결과 일부

## 자동 포함하지 않음

아래 항목은 Task context pack에 자동 포함하지 않습니다.

- 일반 `docs/` 전체
- validation 문서와 workflow skill 문서
- 다른 Job의 Task 결과
- Job에 연결되지 않은 임의 repository 파일
- consumed/rejected/resolved/superseded/archived memory

`AGENTS.md`는 세션 수준 통제 규칙이며 Task artifact가 아닙니다. Task 실행 입력으로 재현해야
하는 문맥은 Job `context_refs`, Task `required_docs`, Task `memory_refs`로 명시해야 합니다.
