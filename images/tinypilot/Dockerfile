FROM ubuntu:22.04

# 필요한 패키지 설치
RUN apt-get update && apt-get install -y \
    curl \
    sudo \
    git \
    build-essential \
    python3 \
    python3-pip \
    python3-dev \
    libevent-dev \
    libjpeg-turbo8-dev \
    uuid-dev \
    libbsd-dev \
    make \
    gcc \
    libjpeg-dev \
    libuuid1 \
    libbsd0 \
    nodejs \
    npm

# TinyPilot 소스 코드 복사
COPY . /opt/tinypilot

WORKDIR /opt/tinypilot

# Python 및 Node.js 의존성 설치
RUN pip install --upgrade pip
RUN pip install greenlet==1.1.0
RUN pip install -r requirements.txt
RUN npm install prettier@2.0.5

RUN mkdir -p /home/tinypilot && chown -R $(whoami) /home/tinypilot

# 환경 변수 설정
ENV APP_SETTINGS_FILE=/opt/tinypilot/config.py

# 포트 설정
EXPOSE 8000
