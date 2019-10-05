FROM maven:3-jdk-8

LABEL "com.github.actions.name"="Project Piper Maven Builder"
LABEL "com.github.actions.description"="Project Piper Maven Builder"
LABEL "com.github.actions.icon"="play"
LABEL "com.github.actions.color"="green"

LABEL "repository"="https://github.com/sap/devops-docker-cx-server"
LABEL "homepage"="https://github.com/sap/devops-docker-cx-server"
LABEL "maintainer"="SAP SE"

ENTRYPOINT ["mvn", "package", "--update-snapshots", "--batch-mode", "--projects", "application", \
            "--file", "/github/workspace/pom.xml", "-Dmaven.test.skip=true"]
