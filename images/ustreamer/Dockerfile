# 베이스 이미지로 Ubuntu 22.04 사용
FROM ubuntu:22.04

# 필요한 패키지 설치
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    pkg-config \
    libevent-dev \
    libjpeg-dev \
    libbsd-dev \
    curl \
    git

# ustreamer는 소스 코드를 직접 빌드해야 하므로,
# 작업 디렉토리를 만들고 그 안에서 작업을 수행합니다.
WORKDIR /opt/ustreamer

# --- 이 줄을 추가해 주세요! ---
# build context(./images/ustreamer/)의 모든 내용을 현재 WORKDIR(/opt/ustreamer)로 복사
COPY . .

# 이제 소스 코드가 복사되었으므로 make가 정상적으로 동작합니다.
RUN make && make install

# 노출할 포트 설정
EXPOSE 8001
