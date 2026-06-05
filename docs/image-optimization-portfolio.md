# Image Optimization Portfolio Notes

## 현재 결론

2026-06-05 bastion에 배포된 ARM64 이미지 기준으로 TinyPilot과 uStreamer는
멀티스테이지 빌드와 런타임 의존성 축소가 실제 운영 이미지에 적용되어 있다.

실행 중인 Compose tag:

```text
IMAGE_TAG=f2dde7cac617
```

실측 크기:

| Image | 이전 단일 스테이지 기준 | 현재 라이브 이미지 | 개선 |
| --- | ---: | ---: | ---: |
| TinyPilot | 약 1.2GB | 182MB | 약 84.8% 감소 |
| uStreamer | 약 800MB | 75.5MB | 약 90.6% 감소 |

이전 포트폴리오/archive 문서에는 TinyPilot 2.84GB, uStreamer 755MB 또는 800MB 등
측정 시점이 다른 수치가 섞여 있다. 현재 포트폴리오에는 위 라이브 검증값을 우선
사용한다.

## 이전 코드와 현재 코드 차이

### TinyPilot

이전 `images/tinypilot/Dockerfile`은 단일 Ubuntu stage에서 빌드 도구와 런타임을
같이 설치했다.

- `build-essential`, `python3-dev`, `gcc`, `nodejs`, `npm`이 최종 이미지에 남았다.
- `pip install -r requirements.txt`를 최종 이미지에서 직접 수행했다.
- apt cache와 테스트/개발 디렉터리 정리가 없었다.

현재 `images/tinypilot/Dockerfile.optimized`는 builder/runtime을 분리한다.

- builder stage에서 Python wheel을 만든다.
- runtime stage에는 Python 실행, libevent, libjpeg, uuid, libbsd 등 실행 의존성만 둔다.
- wheel 설치 후 `/wheels`, `__pycache__`, `*.pyc`, 테스트 파일, `dev-scripts`,
  `e2e`, `bundler`, `debian-pkg`를 제거한다.
- `USER nobody`로 실행해 root runtime을 피한다.
- HTTP healthcheck를 추가했다.

### uStreamer

이전 `images/ustreamer/Dockerfile`은 단일 Ubuntu stage에서 `make && make install`을
실행했다.

- `build-essential`, `cmake`, `pkg-config`, `libevent-dev`, `libjpeg-dev`, `git`이
  최종 이미지에 그대로 남았다.
- apt cache 정리와 문서/매뉴얼 제거가 없었다.

현재 `images/ustreamer/Dockerfile.optimized`는 builder/runtime을 분리한다.

- builder stage에서 uStreamer를 컴파일하고 `/install` 아래로 설치 결과만 모은다.
- runtime stage에는 libevent, libjpeg-turbo, libbsd, curl만 둔다.
- `/usr/local/share/man`, `/usr/local/share/doc`를 제거한다.
- `/state` healthcheck를 추가했다.

## 포트폴리오에 사용할 수 있는 문장

```text
레거시 TinyPilot KVM stack을 Docker Compose 기반 운영 구조로 재정리하면서,
단일 스테이지 Dockerfile을 멀티스테이지 빌드로 교체했다. 빌드 도구와 개발
파일을 runtime image에서 제거하고, 실행 의존성만 남긴 결과 ARM64 배포 이미지
기준 TinyPilot은 약 1.2GB에서 182MB로, uStreamer는 약 800MB에서 75.5MB로
감소했다. Jenkins는 Git commit SHA 기반 immutable tag를 빌드/푸시하고,
Ansible 배포는 해당 commit tag만 허용하도록 변경해 latest fallback에 따른
비결정적 배포 위험을 줄였다.
```

## 검증 명령

bastion에서 실행한 확인 명령:

```bash
docker compose ps --format "{{.Service}} {{.Image}} {{.Status}}"
docker image ls --format "{{.Repository}}:{{.Tag}} {{.ID}} {{.Size}}" |
  grep -E "harbor.*tinypilot/(tinypilot|ustreamer|tailscale)"
curl -sS -I --max-time 5 http://localhost:8000/
curl -sS --max-time 5 http://localhost:8001/state
```

확인 결과:

```text
tinypilot  182MB   Up (healthy)
ustreamer  75.5MB  Up (healthy)
tailscale  114MB   Up

http://localhost:8000/      HTTP 200
http://localhost:8001/state online: true
https://tinypilot.tail2dac17.ts.net/ HTTP/2 200
```

## 남은 개선 포인트

- Jenkins build log에 이미지 크기 출력은 추가했지만, Harbor API 기반 크기 추적은 아직 없다.
- bastion에는 과거 `latest`와 dangling 이미지가 남아 있으므로 별도 prune 정책이 필요하다.
- Ansible은 현재 compose 배포 스크립트를 호출한다. 추후에는 pull/up/restart 판단을
  Ansible task로 더 흡수해 멱등성 경계를 명확히 할 수 있다.
