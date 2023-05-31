# syntax=docker/dockerfile:1.4
FROM ubuntu:23.04 AS builder

ARG DEBIAN_FRONTEND=noninteractive
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update && apt-get install zsh curl git nano locales -y 
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  

WORKDIR /scratch

COPY locksTool/ /scratch/locksTool

RUN buildDeps="autoconf \
                automake \
                cmake \
                curl \
                bzip2 \
                libexpat1-dev \
                g++ \
                gcc \
                git \
                gperf \
                libtool \
                make \
                meson \
                nasm \
                perl \
                pkg-config \
                libssl-dev \
                yasm \
                zlib1g-dev" && \
        apt-get -yqq update && \
        apt-get install -yq --no-install-recommends ${buildDeps}

COPY --chmod=755 <<EOF /scratch/build.sh
#!/usr/bin/env bash
set -euf -o pipefail

cd /scratch/locksTool

# create make
cmake -S . -B ./build
# build target
cmake --build ./build
EOF

RUN "/scratch/build.sh"

FROM builder AS final

# util-linux for flock
RUN apt-get update && apt-get install bash util-linux lsof -y \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

WORKDIR /scratch

COPY --from=builder /scratch/locksTool/build/locks /scratch/locks
COPY flock_a_file.sh /scratch/locks

# COPY --chmod=755 <<EOF /scratch/create.sh
# #!/usr/bin/env bash
# EOF

# RUN /scratch/create.sh

RUN [ "/bin/bash"]
