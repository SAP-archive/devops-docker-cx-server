#!/bin/bash
set -o errexit

VERSION=$1
DOCKERHUB_USER=$2
DOCKERHUB_PASSWORD=$3

if [[ ${VERSION} != latest ]] && [[ ${VERSION} != "v"* ]]; then
    echo "Error: Version must be 'latest' or 'v*'"
    exit 0
fi

build_image() {
    local TAG=$1
    local DIR=$2

    if [ "x${VERSION}" = xlatest ]; then
        # Create a backup of the image to allow rollback in case of failure
        docker pull ${TAG}:latest
        docker tag ${TAG}:latest ${TAG}:backup-of-latest
    fi

    # Build the Release Candidate
    docker build ${DIR} --tag ${TAG}:${VERSION}-RC
}

smoke_test() {
    # Test Jenkins master image
    docker run --name cx-jenkins-master-test --detach --publish 8080:8080 \
        -v /var/run/docker.sock:/var/run/docker.sock \
        ppiper/jenkins-master:${VERSION}-RC
    # Wait up to 5 minutes for Jenkins to be up and fail if it does not return 200 after this time
    docker exec cx-jenkins-master-test timeout 300 bash -c "until curl --fail http://localhost:8080/api/json; do sleep 5; done"
    # Check for 'SEVERE' messages in Jenkins log (usually caused by plugin or configuration issues)
    docker logs cx-jenkins-master-test 2> >(grep --quiet SEVERE)
    # Print plugin config
    docker exec cx-jenkins-master-test bash -c "curl http://localhost:8080/pluginManager/api/xml?depth=1"
}

push_image() {
    local TAG=$1

    docker tag ${TAG}:${VERSION}-RC ${TAG}:${VERSION}

    if [ "x${VERSION}" = xlatest ]; then
        echo docker push ${TAG}:backup-of-latest
    fi

#fixme echos
    echo docker push ${TAG}:${VERSION}
}

build_image ppiper/jenkins-master jenkins-master
build_image ppiper/jenkins-agent jenkins-agent
build_image ppiper/jenkins-agent-k8s jenkins-agent-k8s
build_image ppiper/cx-server-companion cx-server-companion

smoke_test

if [[ ${GITHUB_REF##*/} != master ]] && [[ ${GITHUB_REF##*/} != "v"* ]]; then
    echo "Not pushing on ref ${GITHUB_REF}"
    exit 0
fi

if [ -z ${DOCKERHUB_USER+x} ]; then
    echo "DOCKERHUB_USER is unset, cannot push to Docker Hub";
    exit 1
fi

if [ -z ${DOCKERHUB_PASSWORD+x} ]; then
    echo "DOCKERHUB_PASSWORD is unset, cannot push to Docker Hub";
    exit 1
fi

echo ${DOCKERHUB_PASSWORD} | docker login -u ${DOCKERHUB_USER} --password-stdin
push_image ppiper/jenkins-master
push_image ppiper/jenkins-agent
push_image ppiper/jenkins-agent-k8s
push_image ppiper/cx-server-companion
