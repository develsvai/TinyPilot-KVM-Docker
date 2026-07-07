# Context

## Project Memory

# TinyPilot-KVM-Docker

Loom 프로젝트 메모리 루트입니다.

이 파일은 `loom init`으로 생성되며 `loom analyze-repo`로 보강할 수 있습니다.

## Job

- Title: 레포 작업 히스토리 복원
- Goal: 과거 레포 작업을 Loom Job/Task/Event 기억으로 복원합니다. 관찰된 근거와 추론된 결정을 분리하고 신뢰도를 명시합니다.
- Branch: develop
- Task count: `6`

## Task

- Title: 과거 Task 후보 복원
- Description: 각 draft Job 안에서 의미 있는 커밋 또는 작은 커밋 묶음을 Task 후보로 재구성합니다. 사용자에게 보이는 구조화 필드는 한국어로 작성합니다.
- Expected output: `.loom/imports/import-history-20260701-090917-tinypilot-kvm-docker-d8897e4d/task-drafts.json`에 예상 산출물, 완료 조건, 범위가 포함된 Task 후보가 기록됩니다. `title`, `description`, `expected_output`, `done_condition`, `in_scope`, `out_of_scope`, `validation_hint`, 추론된 `result/decision/troubleshooting`은 한국어여야 합니다.
- Done condition: Task 후보는 실행 가능한 작업 단위이며 관찰 사실과 추론 의도를 분리하고 사용자 표시 필드는 한국어입니다.
- In scope: 커밋 클러스터링, Task 제목/설명 초안, result/decision/troubleshooting 추론.
- Out of scope: 아직 `.loom/jobs` 또는 `.loom/tasks`에 draft를 적용하지 않습니다.
- Validation hint: 모든 Task가 commit 또는 docs를 인용하고, 추론이면 confidence/open questions를 포함하는지 확인합니다.
- Required docs: -
- Memory refs: -
- Status: PENDING
- Assigned agent: codex

## Inclusion Policy

- Mandatory execution files: `prompt.md`, `context.md`, and `previous-results.md`.
- Always included: project memory, current Job/Task metadata, and Job notes.
- Previous results: up to the latest 2 recorded results from earlier Tasks in this Job.
- Job context refs: explicit Job-scoped references selected by the controlling agent or user.
- Task required docs: mandatory Task-scoped documents; missing refs block validation and execution.
- Task memory refs: mandatory Task-scoped workflow memory references; missing or non-memory refs block validation and execution.
- Repository documents, validation documents, and skill rules: included only through explicit Job context refs, Task required docs, or Task memory refs.
- Active workflow memory is included only while its status is `ACTIVE`.
- Consumed proposals, rejected proposals, resolved memory, superseded memory, and archived memory are excluded.
- Unreferenced repository files and results from other Jobs are not included.
- `AGENTS.md` remains a session-level controlling-agent rule source and is not treated as a task context artifact by default.

## Job Notes

# Notes

## Import History import-history-20260701-090917-tinypilot-kvm-docker-d8897e4d

- Reconstruct prior repository work as Loom workflow memory.
- Keep observed evidence, inferred decisions, confidence, and open questions separate.
- Import workspace: `.loom/imports/import-history-20260701-090917-tinypilot-kvm-docker-d8897e4d`
- Commit range: `-` -> `-`
- Max commits scanned: `200`

### Artifacts

- `.loom/imports/import-history-20260701-090917-tinypilot-kvm-docker-d8897e4d/manifest.json`
- `.loom/imports/import-history-20260701-090917-tinypilot-kvm-docker-d8897e4d/audit-metadata.json`
- `.loom/imports/import-history-20260701-090917-tinypilot-kvm-docker-d8897e4d/repo-scan.md`
- `.loom/imports/import-history-20260701-090917-tinypilot-kvm-docker-d8897e4d/git-history.json`
- `.loom/imports/import-history-20260701-090917-tinypilot-kvm-docker-d8897e4d/source-docs.json`
- `.loom/imports/import-history-20260701-090917-tinypilot-kvm-docker-d8897e4d/job-drafts.json`
- `.loom/imports/import-history-20260701-090917-tinypilot-kvm-docker-d8897e4d/task-drafts.json`
- `.loom/imports/import-history-20260701-090917-tinypilot-kvm-docker-d8897e4d/evidence-map.json`
- `.loom/imports/import-history-20260701-090917-tinypilot-kvm-docker-d8897e4d/confidence-review.md`
- `.loom/imports/import-history-20260701-090917-tinypilot-kvm-docker-d8897e4d/apply-plan.json`
- `.loom/imports/import-history-20260701-090917-tinypilot-kvm-docker-d8897e4d/reconstruction-report.md`

### Execution

- Foreground: `loom task run <task-id>`
- Agent process: `loom task exec <task-id> --agent codex`
- Job session: `loom worker run --mode job-session --job-id job-20260701-090917-job-318bb3e3 --agent codex`
- Queued task request: `loom job enqueue job-20260701-090917-job-318bb3e3 --agent codex` then `loom worker run --mode requests --agent codex`

## Context References

No explicit context references recorded for this job.

## Required Documents and Memory

No task-level required docs or memory refs recorded.

## Active Workflow Memory

No active workflow memory recorded.
