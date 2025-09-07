# 🖥️ TinyPilot 기반 커스텀 KVM-over-IP 솔루션 구축

## 1. 프로젝트 개요

이 프로젝트는 오픈소스 원격 KVM 솔루션인 **TinyPilot**을 라즈베리파이 환경에 구축하고,  
**공식적으로 지원되지 않는 Docker 기반 배포**를 통해 안정성과 이식성을 확보한 과정을 다룹니다.

- 리눅스 커널의 **USB Gadget API**를 직접 제어하여 HID 장치를 커스텀 구현
- 서비스 전체를 **Docker Compose**로 오케스트레이션
- 시스템 하드웨어 수준에서의 **호환성 문제 해결 및 디버깅 과정 포함**

> 🔗 공식 저장소: https://github.com/develsvai/TinyPilot-KVM-Docker
>
> 📘 관련 포스트: https://developsvai5096.tistory.com/45

---

## 2. 최종 아키텍처

이 프로젝트는 TinyPilot을 이루는 주요 서비스들을 각각 다른 Docker 컨테이너에 나눠 담고,  
Nginx를 통해 전체 서비스를 하나로 합치는 구조입니다.

- **Nginx**: 모든 요청을 제일 먼저 받는 문지기 역할
- **TinyPilot 컨테이너**: 키보드/마우스 입력 처리 및 UI 제공
- **uStreamer 컨테이너**: 비디오 캡처 카드 화면을 실시간 스트리밍
- **호스트 시스템 (라즈베리파이)**: 실제 하드웨어 장치 파일(`/dev/hidg*`, `/dev/video*`) 생성 및 마운트

---

## 3. 핵심 문제 해결: HID Gadget 마우스 오작동 디버깅

### 🎯 문제 현상
- 의도하지 않은 우클릭 반복 발생
- 마우스 커서가 화면 특정 위치에 고정
- 때때로 마우스 장치 인식 불가 (먹통 현상)

### 🧪 디버깅 흐름

| 단계 | 설명 |
|------|------|
| 가설 수립 | TinyPilot은 **절대 좌표(Absolute)** 방식 전송, 내 장치는 **상대 좌표(Relative)** 수신 |
| 공식 디스크립터 적용 | 오히려 커서가 **완전히 정지**됨 (기능 과다 문제) |
| 최종 원인 | **데이터 길이 불일치**<br>→ TinyPilot은 7바이트, 장치는 5바이트 수신 기대 |
| 해결 | **하이브리드 디스크립터** 구현 → 7바이트 수신 후 **휠 데이터 무시** |

---

## 4. Docker 컨테이너 구성

### 4.1 TinyPilot 웹 서버

- web ui 제공
- Flask 기반
- 키보드/마우스 입력 처리
- `/dev/hidg*` 장치 파일에 직접 이벤트 기록
- 포트: 8000

---

### 4.2 uStreamer

- 비디오 스트림 송출
- 캡처 카드의 `/dev/video0`을 직접 사용
- 포트: 8001

---

### 4.3 Nginx Reverse Proxy

- WebSocket 및 비디오 스트림 분기
- `/stream`, `/snapshot`, `/socket.io`, 정적 파일 등 경로별 요청 처리
- 포트: 8900 (외부 접속용)

---

## 5. Docker Compose 통합 실행

- `tinypilot`, `ustreamer`, `nginx` 3개의 서비스 정의
- `/dev/hidg*`와 `/dev/video0` 장치 파일을 각각 마운트
- 의존성 컨테이너 구성 (`depends_on`)
- 설정 파일과 명령어는 각 컨테이너별로 명시

---

## 6. 설치 및 실행 방법

### ✅ 사전 요구사항
- Raspberry Pi 4 이상
- Docker / Docker Compose 설치
- 비디오 캡처 카드 연결

### 실행
```bash 
sudo sh ./runsh
```

### 🛠️ 레포지토리 클론

```bash
https://github.com/develsvai/TinyPilot-KVM-Docker.git
```
