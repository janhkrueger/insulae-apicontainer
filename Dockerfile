FROM ubuntu:hirsute
LABEL maintainer="janhkrueger@outlook.com"

RUN TZ=UTC && \
    apt-get update && \ 
    apt-get -y --no-install-recommends install libpqxx-dev curl libcurl4-openssl-dev libcurl4 libssl-dev && \
    apt-get clean autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/cache/* && \
    rm -rf /var/log/* && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

ENTRYPOINT ["/home/insulae/insulae-bin/api_server"]
HEALTHCHECK --interval=5s --timeout=2s --retries=12 \
  CMD curl --silent --fail localhost:9080/ready || exit 1
