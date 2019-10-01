#!/bin/bash -ex

echo "Branch $TRAVIS_BRANCH"

if [ "$TRAVIS_BRANCH" == "master" ]; then
    docker push ppiper/jenkinsfile-runner:latest
    docker push ppiper/jenkins-master:latest
    docker push ppiper/cx-server-companion:latest
fi

if [ "$TRAVIS_TAG" ] ; then

fi
