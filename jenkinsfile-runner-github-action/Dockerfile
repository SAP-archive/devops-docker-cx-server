# Inhereting form 'latest' Jenkins master is ok since this image is controlled by us
# hadolint ignore=DL3006
FROM ppiper/jenkins-master

ENV JENKINSFILE_RUNNER_VERSION 1.0-beta-9
ENV CASC_JENKINS_CONFIG=/github/workspace/jenkins.yml

VOLUME /tmp

LABEL "com.github.actions.name"="Project Piper Jenkinsfile Runner"
LABEL "com.github.actions.description"="Runs a Project Piper based Jenkinsfile in a short-lived Jenkins master"
LABEL "com.github.actions.icon"="play"
LABEL "com.github.actions.color"="green"

LABEL "repository"="https://github.com/sap/devops-docker-cx-server"
LABEL "homepage"="https://github.com/sap/devops-docker-cx-server"
LABEL "maintainer"="SAP SE"

# User needs to be root for access to mounted Docker socket
# hadolint ignore=DL3002
USER root
RUN curl -O https://repo.jenkins-ci.org/releases/io/jenkins/jenkinsfile-runner/jenkinsfile-runner/$JENKINSFILE_RUNNER_VERSION/jenkinsfile-runner-$JENKINSFILE_RUNNER_VERSION-app.zip && \
    unzip jenkinsfile-runner-$JENKINSFILE_RUNNER_VERSION-app.zip -d jenkinsfile-runner && \
    rm jenkinsfile-runner-$JENKINSFILE_RUNNER_VERSION-app.zip && \
    chmod +x /jenkinsfile-runner/bin/jenkinsfile-runner

RUN mkdir /jenkins-war && unzip /usr/share/jenkins/jenkins.war -d /jenkins-war && \
    mkdir -p /var/cx-server/jenkins-configuration

ENTRYPOINT ["/jenkinsfile-runner/bin/jenkinsfile-runner", \
            "--jenkins-war", "/jenkins-war", \
            "--plugins", "/usr/share/jenkins/ref/plugins", \
            "--file", "/github/workspace", \
            "--no-sandbox"]
