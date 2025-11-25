FROM ubuntu:24.04

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    gnupg \
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

WORKDIR /work
