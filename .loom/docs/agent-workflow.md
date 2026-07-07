# Agent Workflow Contract

## 제품 원칙

```text
Agent proposes.
User controls.
Loom preserves.
```

AI는 코드를 생성하고, 사람은 방향을 결정하며, Loom은 그 과정이 사라지지 않게 보존합니다.

## 세션 시작

통제 에이전트는 새 workspace 세션을 시작할 때 아래 순서를 따릅니다.

1. `loom agent instructions --json`을 실행하고 반환된 계약을 현재 세션의 상위 행동 규칙으로 읽습니다.
2. 반환된 `startup_notice`를 사용자에게 한 번 고지합니다.
3. `loom status --json`, `loom resume --json`, `loom validate --strict`로 현재 상태를 확인합니다.

## 실행 경로

- 사용자가 현재 에이전트에게 직접 실행을 맡긴 경우에만 foreground `loom task run`을 사용합니다.
- 실행은 승인됐지만 현재 에이전트에게 직접 맡기지 않은 경우 Queue/Worker 경로를 사용합니다.
- 사용자가 실행을 승인하지 않은 경우 계약 작성과 보완까지만 수행합니다.

## Planning Agent 규칙

- 사용자 입력을 바로 Task로 만들지 않고 질문, Proposal, Memory, 기존 Task 보완, 후속 Job/Task 후보로 분류합니다.
- Task를 만들기 전에 기존 Job과 완료 Job 중 같은 목표의 후속 작업을 받을 수 있는 Job이 있는지 확인합니다.
- Job 경계는 사용자 목표, 기능 영역, workflow 표면, 최근 작업 내역의 연속성을 기준으로 판단합니다.
- 작업 묶음을 Task로 구성할 때는 기본적으로 작업 경계 확인 -> 구현/적용 -> 검증 순서가 이어지게 합니다.
- Worker는 주어진 Task 계약을 실행하고 결과를 남기는 역할이며, 새 Job/Task를 생성하거나 사용자 Memory 제안을 확정하지 않습니다.

## 종료

작업 종료 전 `loom validate --strict`와 `loom resume --json`으로 metadata와 이어받기 상태를 확인합니다.
