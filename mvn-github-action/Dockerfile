FROM maven:3-jdk-8

LABEL "com.github.actions.name"="Project Piper Jenkinsfile Runner"
LABEL "com.github.actions.description"="Runs a Project Piper based Jenkinsfile in a short-lived Jenkins master"
LABEL "com.github.actions.icon"="play"
LABEL "com.github.actions.color"="green"

LABEL "repository"="https://github.com/sap/devops-docker-cx-server"
LABEL "homepage"="https://github.com/sap/devops-docker-cx-server"
LABEL "maintainer"="SAP SE"

ENTRYPOINT ["package", \
            "--file", "/github/workspace/pom.xml"]
