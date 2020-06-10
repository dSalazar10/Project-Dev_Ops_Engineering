FROM jenkins/jenkins:lts
# Update and install applications
USER root
# Install Docker
RUN apt-get update && \
    apt-get install -y apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common && \
    curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; \
    echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
    add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
    $(lsb_release -cs) \
    stable" && \
    apt-get update && \
    apt-get install -y docker-ce
RUN apt-get install -y docker-ce
# Install Docker Compose
RUN apt-get update \
    && curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose
# Assign user to Docker group
RUN usermod -a -G docker jenkins
# Install NodeJS
RUN apt-get update \
    && curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get update \
    && apt-get install -y nodejs
# Install HadoLint
RUN apt-get update \
    && wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.17.6/hadolint-Linux-x86_64
RUN apt-get update \
    && chmod +x /bin/hadolint
RUN apt-get update \
      && apt-get install -y sudo \
      && rm -rf /var/lib/apt/lists/*
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers
USER jenkins
RUN sudo service docker start