FROM jenkins/jenkins:2.401.1
USER root
RUN apt-get update && \
    apt-get install -y curl unzip && \
    apt-get install -y wget && \
    curl -s https://raw.githubusercontent.com/aquasecurity/tfsec/master/scripts/install_linux.sh | bash && \
    apt-get install -y lsb-release
RUN curl -LO https://releases.hashicorp.com/terraform/1.4.6/terraform_1.4.6_linux_amd64.zip && \
    unzip terraform_1.4.6_linux_amd64.zip && \
    mv terraform /usr/local/bin/ && \
    rm terraform_1.4.6_linux_amd64.zip
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli
USER jenkins
RUN jenkins-plugin-cli --plugins "blueocean docker-workflow"
