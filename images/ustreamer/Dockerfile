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

# ustreamer 소스 코드를 clone 합니다.
# (현재 방식은 서브모듈로 이미 코드가 있으므로 이 단계는 사실상 필요 없지만,
# 독립적인 Dockerfile을 위해 명시적으로 포함하는 것이 좋습니다.
# build context에 이미 코드가 있으므로 아래 RUN은 생략해도 됩니다.)
# RUN git clone https://github.com/pikvm/ustreamer.git .

# ustreamer 빌드 및 설치
RUN make && make install

# 노출할 포트 설정
EXPOSE 8001
