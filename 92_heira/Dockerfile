FROM ubuntu:24.04

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    wget \
    gnupg \
    jq \
    lsb-release \
    ruby \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSLo /tmp/puppet8-release.deb https://apt.puppet.com/puppet8-release-noble.deb \
    && dpkg -i /tmp/puppet8-release.deb \
    && rm /tmp/puppet8-release.deb \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y puppet-agent \
    && rm -rf /var/lib/apt/lists/*

#RUN gem install hiera-eyaml

ENV PATH="/opt/puppetlabs/bin:/opt/puppetlabs/puppet/bin:${PATH}"

COPY --chmod=755 <<EOF /bin/install_task.sh
#!/usr/bin/env bash
# Install Taskfile (Task)
echo "Installing Taskfile..."
TASK_VERSION=$(curl -s https://api.github.com/repos/go-task/task/releases/latest | grep '"tag_name":' | cut -d '"' -f 4)
if [ -n "\$TASK_VERSION" ]; then
    TMP_DIR=$(mktemp -d)
    cd "\$TMP_DIR" || exit 1
    if wget -q "https://github.com/go-task/task/releases/download/\${TASK_VERSION}/task_linux_amd64.tar.gz"; then
        tar -xzf "task_linux_amd64.tar.gz"
        mv task /usr/local/bin/
        chmod +x /usr/local/bin/task
        cd - > /dev/null || exit 1
        rm -rf "\$TMP_DIR"
        echo "Taskfile installed: $(task --version)"
    else
        cd - > /dev/null || exit 1
        rm -rf "\$TMP_DIR"
        echo "Warning: Taskfile download failed. Skipping..."
    fi
else
    echo "Warning: Could not determine Taskfile version. Skipping..."
fi
EOF

RUN /bin/install_task.sh
# && rm /bin/install_task.sh

WORKDIR /work
