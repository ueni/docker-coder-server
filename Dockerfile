FROM linuxserver/code-server:latest

LABEL maintainer="ueniueni, ueni"

ENV VERSION=1.0.0.0

ARG TARGETPLATFORM

#linux/arm/v7

RUN rm /bin/sh && ln -sf /bin/bash /bin/sh

RUN \
    source /etc/lsb-release && \
    PLATFORM=${TARGETPLATFORM/linux\//}; \
    PLATFORM=${PLATFORM/arm\/v7/armhf}; \
    PLATFORM=${PLATFORM/arm\/v6/armhf}; \
    echo "**** install docker cli for $TARGETPLATFORM ($PLATFORM) in ubuntu $DISTRIB_CODENAME ****"; \
    apt-get update && \
    apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg-agent \
        software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add - && \
    add-apt-repository \
        "deb [arch=${PLATFORM}] https://download.docker.com/linux/ubuntu \
        $DISTRIB_CODENAME \
        stable" && \
    apt-get update && \
    apt-get install -y \
        docker-ce-cli && \
    apt-get clean && \
    rm -rf \
        /tmp/* \
        /var/lib/apt/lists/* \
        /var/tmp/*

VOLUME /var/run/docker.sock