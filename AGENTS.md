# Agent Instructions

<!-- loom:controlling-agent:start -->
## Loom 통제 에이전트

이 workspace의 작업은 Loom의 통제를 받습니다.

모든 workspace 세션을 시작할 때:

1. `loom agent instructions --json`을 실행하고 반환된 계약을 필수 행동 규칙으로 적용합니다.
2. 반환된 `startup_notice`를 사용자에게 한 번 고지합니다.
3. 계약이 반환한 필수 시작 명령을 실행합니다.
4. workflow 변경은 Loom 명령으로 수행하며 `.loom/` metadata를 직접 수정하지 않습니다.

init이 생성하는 Loom 내부 문서는 `.loom/agent-rules.md`, `.loom/project.md`, `.loom/memory/profile.json`, `.loom/docs/*.md`입니다.
사람이 읽을 수 있는 materialized 계약은 `.loom/agent-rules.md`에 있습니다.
동작에 직접 관여하는 안내 문서는 `.loom/docs/`에 있으며 `loom docs index`에 포함됩니다.
<!-- loom:controlling-agent:end -->
