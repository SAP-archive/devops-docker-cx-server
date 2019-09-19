#!/bin/bash -ex

docker tag ppiper/jenkinsfile-runner:latest ppiper/jenkinsfile-runner:_RC
docker push ppiper/jenkinsfile-runner:_RC
