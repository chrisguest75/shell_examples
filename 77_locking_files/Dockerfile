# syntax=docker/dockerfile:1.4
FROM ubuntu:23.04 AS BUILDER

RUN apt-get update && apt-get install bash util-linux lsof -y \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

WORKDIR /scratch

# COPY --chmod=755 <<EOF /scratch/create.sh
# #!/usr/bin/env bash
# EOF

# RUN /scratch/create.sh

RUN [ "/bin/bash"]
