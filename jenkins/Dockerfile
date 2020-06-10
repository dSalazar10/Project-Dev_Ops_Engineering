FROM jenkins/jenkins:lts
# Update and install applications
USER root
# Install Docker
RUN apt-get update \
    && curl -fsSL https://get.docker.com -o get-docker.sh
RUN sh get-docker.sh
# Install NodeJS
RUN apt-get update \
    && curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get update \
    && apt-get install -y nodejs
# Assign user to Docker group
RUN usermod -uG docker jenkins
# Install Docker Compose
RUN apt-get update \
    && curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose
# Install HadoLint
RUN apt-get update \
    && wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.17.6/hadolint-Linux-x86_64
RUN apt-get update \
    && chmod +x /bin/hadolint
    
USER jenkins
