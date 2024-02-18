FROM jenkins/inbound-agent

WORKDIR /home/jenkins/agent
USER root
ADD docker /usr/bin/docker
RUN chmod -R a+rwx /usr/bin
RUN groupadd docker
RUN usermod -aG docker jenkins

RUN curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

USER jenkins