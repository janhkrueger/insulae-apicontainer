FROM ubuntu:latest
LABEL maintainer="janhkrueger@outlook.com"

RUN TZ=UTC  && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \  
    apt install -y tzdata && \
    apt-get -y --no-install-recommends install libpqxx-dev curl libcurl4-openssl-dev libcurl4 libssl-dev git cmake make build-essential autoconf automake software-properties-common gnu-standards && \
    apt-get -y --fix-missing --no-install-recommends install libatomic1 && \ 
    git config --global http.sslverify false && \
    git clone https://gitlab.com/insulae_dev/external-components/curlpp.git && \
    cd curlpp/ && \
    mkdir build && \
    cd build/ && \
    cmake .. && \
    make && \
    make install && \
    make clean && \
    cd .. && \    
    cd .. && \    
    rm -rf curlpp && \ 
    git clone https://gitlab.com/insulae_dev/external-components/libvault.git && \
    cd libvault/ && \
    mkdir build && \
    cd build/ && \
    cmake -DENABLE_TEST=OFF -DLINK_CURL=ON .. && \
    make && \
    make install && \
    make clean && \
    cd .. && \
    cd .. && \
    rm -rf libvault && \ 
    apt-get -y remove git cmake make build-essential autoconf automake software-properties-common gnu-standards && \
    apt-get clean autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/cache/* && \
    rm -rf /var/log/* && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* 

ENTRYPOINT ["/home/insulae/insulae-bin/api_server"]
HEALTHCHECK --interval=5s --timeout=2s --retries=12 \
  CMD curl --silent --fail localhost:9080/ready || exit 1
