#!/bin/bash -ex

# Start a local registry, to which we push the images built in this test, and from which they will be consumed in the test
docker run -d -p 5000:5000 --restart always --name registry registry:2 || true
find ../cx-server-companion -type f -exec sed -i -e 's/ppiper/localhost:5000\/ppiper/g' {} \;

# Copy over life cycle script for testing
cp ../cx-server-companion/life-cycle-scripts/{cx-server,server.cfg} .
mkdir -p jenkins-configuration
cp testing-jenkins.yml jenkins-configuration

docker build -t localhost:5000/ppiper/jenkins-master:latest ../jenkins-master
docker build -t localhost:5000/ppiper/cx-server-companion:latest ../cx-server-companion

docker tag localhost:5000/ppiper/jenkins-master:latest ppiper/jenkins-master:latest
docker tag localhost:5000/ppiper/cx-server-companion:latest ppiper/cx-server-companion:latest

docker push localhost:5000/ppiper/jenkins-master:latest
docker push localhost:5000/ppiper/cx-server-companion:latest

export DEVELOPER_MODE=1

# Boot our unit-under-test Jenkins master instance using the `cx-server` script
TEST_ENVIRONMENT=(CX_INFRA_IT_CF_USERNAME CX_INFRA_IT_CF_PASSWORD DEVELOPER_MODE)
for var in "${TEST_ENVIRONMENT[@]}"
do
   export $var
   echo $var >> custom-environment.list
done
chmod +x cx-server
./cx-server start

# Use Jenkinsfile runner to orchastrate the example project build.
# See `Jenkinsfile` in this directory for details on what is happening.
docker run -v //var/run/docker.sock:/var/run/docker.sock -v $(pwd):/workspace \
 -e CASC_JENKINS_CONFIG=/workspace/jenkins.yml -e HOST=$(hostname) \
 ppiper/jenkinsfile-runner:v2

# cleanup
if [ ! "$TRAVIS" = true ] ; then
    rm -f cx-server server.cfg custom-environment.list
    echo "Modified your git repo, you might want to do a git checkout before re-running."
fi
