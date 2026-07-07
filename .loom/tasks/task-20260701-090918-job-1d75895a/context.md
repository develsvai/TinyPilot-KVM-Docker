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

- Title: 과거 Job 경계 초안 작성
- Description: 커밋/문서 신호를 사람 기준의 과거 Job 후보로 묶습니다. Job은 단일 커밋이 아니라 작업 흐름입니다. 사용자에게 보이는 구조화 필드는 한국어로 작성합니다.
- Expected output: `.loom/imports/import-history-20260701-090917-tinypilot-kvm-docker-d8897e4d/job-drafts.json`에 증거 ref와 confidence가 포함된 Job 후보가 기록됩니다. `title`, `goal`, `confidence_reason`, `open_questions` 같은 사용자 표시 필드는 한국어여야 합니다.
- Done condition: 각 draft Job에 한국어 제목, 목표, 대략적 기간, evidence refs, confidence, open questions가 있습니다.
- In scope: 커밋, 변경 경로, status/task 문서, README/runbook 기반의 boundary 추론.
- Out of scope: 아직 최종 Loom 과거 Job을 생성하지 않습니다.
- Validation hint: 서로 다른 관심사가 섞였는지 확인하고 confidence가 낮으면 deploy/runtime/docs/security 흐름을 분리합니다.
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
