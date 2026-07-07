# 결정

- `loom import-history init --json`이 생성한 스캔 산출물을 source of truth로 사용합니다.
- `git-history.json`의 `scan_coverage.history_truncated`가 `false`이고 `omitted_commit_count`가 `0`이므로, 현재 복원 범위는 전체 Git 히스토리로 간주합니다.
- 이 Task의 범위는 읽기 전용 스캔 확인까지이므로 과거 Job/Task 생성은 다음 Task 이후로 미룹니다.
- 사용자 표시 내용은 Loom 계약에 따라 한국어로 기록하고, commit hash와 원본 commit subject는 그대로 유지합니다.
