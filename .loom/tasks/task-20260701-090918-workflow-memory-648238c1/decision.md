# 결정

- `.loom` metadata를 직접 수정하지 않고 `loom job create`, `loom task create`, `loom note add`만 사용했습니다.
- confidence review에서 apply 가능하다고 판단된 5개 Job, 16개 Task만 반영했습니다.
- 중간 신뢰도 항목은 숨기지 않고 `confidence-review.md`와 `reconstruction-report.md`에 남겼습니다.
- CLI 상태 제약 때문에 복원 Job/Task를 강제 DONE 처리하지 않았습니다. deprecated `loom task set-status`는 상태 머신과 완료 guardrail을 우회하므로 사용하지 않았습니다.
