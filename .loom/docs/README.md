# Loom 내부 동작 문서

이 디렉터리는 `loom init`이 생성하는 Loom 내부 동작 문서를 보관합니다.

`docs/`는 사용자의 프로젝트 문서이고, `.loom/docs/`는 Loom이 에이전트 통제와 Task 실행
경계를 설명하기 위해 생성하는 runtime-facing 문서입니다.

## 문서

- `agent-workflow.md`: 통제 에이전트 행동 계약과 실행 경로
- `context-pack.md`: Task context pack 포함/제외 기준
- `memory-profile.md`: workflow memory 저장 정책과 proposal lifecycle

이 문서들은 `loom docs index`에 포함되며, 필요한 경우 Task의 `required_docs`로 연결할 수
있습니다. canonical contract는 `loom agent instructions --json`과 `.loom/agent-rules.md`입니다.
