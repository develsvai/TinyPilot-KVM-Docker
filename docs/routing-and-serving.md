# Routing And Serving

## 요청 흐름

브라우저는 Tailscale serve를 통해 Tailscale 컨테이너의 nginx로 들어온다.

```text
Browser
  -> Tailscale serve HTTPS port
  -> tailscale container nginx :9090
  -> tinypilot:8000 or ustreamer:8001
```

## TinyPilot이 직접 서빙하는 경로

TinyPilot Flask app은 다음 설정으로 시작한다.

```python
app = flask.Flask(__name__, static_url_path='')
```

따라서 TinyPilot은 정적 파일을 루트 경로에서 직접 제공한다.

예:

- `/css/style.css`
- `/css/button.css`
- `/js/app.js`
- `/js/controllers.js`
- `/img/logo.svg`
- `/favicon.ico`
- `/favicon-16x16.png`
- `/favicon-32x32.png`
- `/apple-touch-icon.png`
- `/third-party/socket.io/4.7.1/socket.io.min.js`
- `/third-party/webrtc-adapter/8.1.1/adapter.min.js`
- `/third-party/janus-gateway/1.0.0/janus.js`

## uStreamer로 가야 하는 경로

다음 경로는 uStreamer로 프록시한다.

- `/stream`
- `/snapshot`
- `/state`

`/stream`은 MJPEG 스트림이므로 nginx buffering을 끈다.

## Socket.IO 경로

다음 경로는 TinyPilot로 프록시하되 WebSocket upgrade header가 필요하다.

- `/socket.io`

## 기존 프록시 문제

이전 Tailscale nginx 설정은 정적 파일 확장자별 regex location을 가지고 있었다.
이 방식은 다음 문제가 있다.

- `.svg`, `.txt`, 일부 nested third-party path가 누락되기 쉽다.
- TinyPilot이 이미 static root serving을 하므로 nginx가 정적 파일을 세부 분기할 필요가 없다.
- `server_name`이 특정 tailnet 도메인에 박혀 있어 hostname 변경에 약하다.

## 권장 프록시 규칙

단순하게 유지한다.

```text
/stream    -> ustreamer:8001
/snapshot  -> ustreamer:8001
/state     -> ustreamer:8001
/socket.io -> tinypilot:8000 with websocket headers
/          -> tinypilot:8000
```

이 방식이면 TinyPilot core가 기대하는 정적 파일 경로를 그대로 보존한다.

## 검증 URL

배포 후 브라우저 또는 curl로 확인한다.

```bash
curl -I http://<host>/css/style.css
curl -I http://<host>/js/app.js
curl -I http://<host>/img/logo.svg
curl -I http://<host>/third-party/socket.io/4.7.1/socket.io.min.js
curl -I http://<host>/snapshot
curl -I http://<host>/state
```

MJPEG stream:

```bash
curl -I http://<host>/stream
```

Socket.IO는 브라우저 개발자 도구 Network 탭에서 websocket upgrade 성공 여부를 본다.
