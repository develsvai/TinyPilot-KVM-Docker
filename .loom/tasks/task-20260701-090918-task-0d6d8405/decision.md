# 결정

- 모든 Task 후보에 `commit_refs`, `source_docs`, 예상 산출물, 완료 조건, 범위, 검증 힌트를 포함했습니다.
- commit subject는 원문을 유지하고, 사용자 표시 필드는 한국어로 작성했습니다.
- 실제 운영상 하나의 문제 해결 흐름으로 보이는 Jenkins/Ansible fix 커밋들은 지나치게 잘게 나누지 않고 실행 의존성, bastion/arm64/runtime, Tailscale HTTPS로 묶었습니다.
- run script 관련 과거 작업은 이후 legacy 제거로 대체되므로 confidence를 `중간`으로 두었습니다.
