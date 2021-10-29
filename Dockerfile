FROM debian:bullseye-20190708-slim

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update -qq && \
    apt-get install -qqy --no-install-recommends \
      apt-transport-https \
      curl \
      ca-certificates \
      git \
      lsb-release \
      gnupg && \
    curl -sL https://packages.microsoft.com/keys/microsoft.asc | \
      gpg --dearmor | \
      tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null && \
    AZ_REPO=$(lsb_release -cs) && \
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | \
      tee /etc/apt/sources.list.d/azure-cli.list && \
      apt-get update -qq && apt-get install -qqy azure-cli && \
    curl -fsSL https://get.docker.com -o get-docker.sh && \
      sh  get-docker.sh && \
    curl -fsSL https://get.pulumi.com | sh  && \  
    rm -rf /var/lib/apt/lists/*