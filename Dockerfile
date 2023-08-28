# syntax=docker/dockerfile:1-labs
FROM amd64/ubuntu:latest AS base

ENV TERM="xterm" LANG="C.UTF-8" LC_ALL="C.UTF-8" TZ="UTC"
ARG HAMDHTTOOLS_INST_DIR=/src/ham-dht-tools OPENDHT_INST_DIR=/src/opendht

# install dependencies
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
    apt update && \
    apt upgrade -y && \
    apt install -y \
        build-essential \
        cmake \
        jq \
        libargon2-0-dev \
        libasio-dev \
        libcppunit-dev \
        libcurl4-gnutls-dev \
        libfmt-dev \
        libgnutls28-dev \
        libhttp-parser-dev \
        libjsoncpp-dev \
        libmsgpack-dev \
        libncurses5-dev \
        libreadline-dev \
        libssl-dev \
        lsof \
        nettle-dev \
        pkg-config

# Setup directories
RUN mkdir -p \
    ${OPENDHT_INST_DIR} \
    ${HAMDHTTOOLS_INST_DIR}

# Clone OpenDHT repository
#ADD --keep-git-dir=true https://github.com/savoirfairelinux/opendht.git#master ${OPENDHT_INST_DIR}
ADD --keep-git-dir=true https://github.com/savoirfairelinux/opendht.git#v2.5.5 ${OPENDHT_INST_DIR}

# Clone ham-dht-tools repository
ADD --keep-git-dir=true https://github.com/n7tae/ham-dht-tools.git#main ${HAMDHTTOOLS_INST_DIR}

# Copy in source code (use local sources if repositories go down)
#COPY src/ /

# Compile and install OpenDHT
RUN cd ${OPENDHT_INST_DIR} && \
    mkdir -p build && \
    cd build && \
    cmake -DOPENDHT_PYTHON=OFF -DCMAKE_INSTALL_PREFIX=/usr .. && \
    make && \
    make install

# Compile and install ham-dht-tools
RUN cd ${HAMDHTTOOLS_INST_DIR}/ && \
    make && \
    ls -al && \
	cp -f dht-get /usr/local/bin && \
    cp -f dht-spider /usr/local/bin && \
    cp -f get-config-params /usr/local/bin

# Cleanup
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
    apt -y purge \
        build-essential \
        cmake \
        pkg-config && \
    apt -y autoremove && \
    apt -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/* && \
    rm -rf /src