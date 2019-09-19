#!/bin/bash -ex

docker build -t ppiper/jenkinsfile-runner jenkinsfile-runner
docker-compose --file jenkinsfile-runner/docker-compose.test.yml build
docker-compose --file jenkinsfile-runner/docker-compose.test.yml run sut

docker build -t ppiper/jenkins-master jenkins-master

docker build -t ppiper/cx-server-companion cx-server-companion
docker build -t ppiper/jenkins-agent-k8s jenkins-agent-k8s
docker build -t ppiper/jenkins-agent jenkins-agent

