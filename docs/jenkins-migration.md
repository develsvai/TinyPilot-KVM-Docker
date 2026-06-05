# Jenkins Migration Plan

## 기존 문제

첨부된 Jenkins 로그의 직접 실패 원인:

```text
groovy.lang.MissingPropertyException: No such property: docker for class: groovy.lang.Binding
```

기존 Jenkinsfile은 다음 DSL에 의존했다.

- `docker.withRegistry`
- `docker.build`

현재 Jenkins에는 Docker Pipeline plugin이 없거나 해당 DSL을 사용할 수 없는 상태다.
따라서 Jenkinsfile은 Docker CLI 기반으로 바꾸는 것이 안전하다.

## 목표 구조

Jenkins item은 Git repository에서 Jenkinsfile을 가져오는 Pipeline item으로 둔다.
`WEB-DOWNLOADER` item이 이미 이 방식일 가능성이 높으므로, 같은 패턴으로 맞춘다.

희망 흐름:

```text
GitHub repository
  -> Jenkins Pipeline item
  -> checkout scm
  -> docker build --platform linux/arm64
  -> docker push to Harbor
  -> dockerized ansible-playbook deploy.yml
  -> bastion Docker Compose deployment
```

## Jenkins item 전환 계획

1. 기존 `Tinypilot` item 설정 백업
2. 기존 `Tinypilot` item 삭제 또는 rename
3. 새 Pipeline item 생성
4. Definition을 `Pipeline script from SCM`으로 설정
5. SCM을 Git으로 설정
6. repository URL 설정
7. branch를 `develop`으로 설정
8. Script Path를 `jenkins/jenkinsfile`로 설정
9. credentials가 필요한 경우 Git credential 연결
10. 첫 빌드 실행

## 필요한 Jenkins credentials

| Credential ID | 용도 |
| --- | --- |
| `harbor-credentials` | Harbor login/build push/pull |
| `bastion-ssh-key` | Jenkins -> bastion SSH |
| `tailscale-auth-key` | Tailscale container bootstrap |

## Jenkins agent 요구사항

agent label:

```text
docker-build-node
```

필수 명령:

- `git`
- `docker`

Docker daemon 접근 권한도 필요하다.
Ansible과 SSH client는 `tools/ansible-runner/Dockerfile`에서 만든 컨테이너 안에서 실행한다.

현재 bastion은 `arm64/aarch64` 호스트라 TinyPilot, uStreamer, Tailscale image build는
`APP_TARGET_PLATFORM=linux/arm64`로 고정한다.
`ansible-runner` 이미지는 Jenkins agent에서 실행되므로 agent native architecture로 빌드한다.

## 확인해야 할 Jenkins 주소

아직 이 저장소 내부에는 Jenkins 접속 URL이 명시되어 있지 않다.

후보 단서:

- `INFRA-MANIFEST/jenkins`
- `INFRA-MANIFEST/docs/reference/jenkins-service-loadbalancer-exposure-design.md`
- 기존 Jenkins UI의 `WEB-DOWNLOADER` item

Jenkins 접근 후 확인할 항목:

- `WEB-DOWNLOADER` item의 SCM 방식
- Git repository URL
- branch 설정 방식
- Script Path
- credentials binding 방식
- agent label

## 주의

Jenkins item 변경은 Jenkins API token 또는 UI 접근 권한이 필요하다.
접근 정보 확인 전에는 저장소 문서와 Jenkinsfile만 준비한다.
