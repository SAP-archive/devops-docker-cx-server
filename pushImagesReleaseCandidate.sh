#!/bin/bash -ex

docker tag ppiper/jenkinsfile-runner:latest ppiper/jenkinsfile-runner:_RC
docker push ppiper/jenkinsfile-runner:_RC

docker tag ppiper/jenkins-master:latest ppiper/jenkins-master:_RC
docker push ppiper/jenkins-master:_RC

docker tag ppiper/cx-server-companion:latest ppiper/cx-server-companion:_RC
docker push ppiper/cx-server-companion:_RC
