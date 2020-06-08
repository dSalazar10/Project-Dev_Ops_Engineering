FROM jenkins/jenkins:lts
# Update and install applications
USER root
# Install Docker
RUN apt-get update \
    && curl -fsSL https://get.docker.com -o get-docker.sh
RUN sh get-docker.sh
RUN usermod -aG docker jenkins
USER jenkins
