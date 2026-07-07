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

- Title: 레포 구조와 히스토리 스캔
- Description: 레포 구조, 프로젝트 문서, Git 히스토리를 읽고 추론 전에 사실 기반 스캔을 작성합니다.
- Expected output: `.loom/imports/import-history-20260701-090917-tinypilot-kvm-docker-d8897e4d/repo-scan.md`와 `.loom/imports/import-history-20260701-090917-tinypilot-kvm-docker-d8897e4d/git-history.json`에 관찰된 레포/커밋 신호가 기록됩니다.
- Done condition: 레포 영역, 중요 문서, 커밋 범위, 생략/약한 근거가 기록되고 과거 Job은 아직 생성하지 않습니다.
- In scope: 읽기 전용 레포 스캔, git log 수집, 문서 inventory, commit/file signal 추출.
- Out of scope: 이 단계에서 과거 Job 또는 Task를 생성하지 않습니다.
- Validation hint: `loom import-history status import-history-20260701-090917-tinypilot-kvm-docker-d8897e4d`를 실행해 scan artifact가 있는지 확인합니다.
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
