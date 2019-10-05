FROM ubuntu

LABEL "com.github.actions.name"="Project Piper Maven Builder"
LABEL "com.github.actions.description"="Project Piper Maven Builder"
LABEL "com.github.actions.icon"="play"
LABEL "com.github.actions.color"="green"

LABEL "repository"="https://github.com/sap/devops-docker-cx-server"
LABEL "homepage"="https://github.com/sap/devops-docker-cx-server"
LABEL "maintainer"="SAP SE"

RUN apt-get -yqq update && apt-get -yqq --no-install-recommends install openjdk-8-jdk-headless maven

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
