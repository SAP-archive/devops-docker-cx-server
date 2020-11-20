#!/bin/bash -ex

# Output docker version in case any api incompatibilies come up
docker version

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

# Boot our unit-under-test Jenkins master instance using the `cx-server` script
TEST_ENVIRONMENT=(CX_INFRA_IT_CF_USERNAME CX_INFRA_IT_CF_PASSWORD)
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

# Test Jenkins default admin credentials
INITIAL_CREDENTIALS=$(docker logs cx-jenkins-master 2>&1 | grep "Default credentials for Jenkins")
ADMIN_PASSWORD=$(echo ${INITIAL_CREDENTIALS} | cut -c 63-)
# File where web session cookie is saved
COOKIEJAR="$(mktemp)"
CRUMB=$(curl -u "admin:$ADMIN_PASSWORD" --cookie-jar "$COOKIEJAR" "http://localhost/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,%22:%22,//crumb)")

# Expect code 403 Forbidden because we are not authorized
ACTUAL_STATUS_CODE_WITHOUT_AUTH=$(curl -s -o /dev/null --cookie "$COOKIEJAR" -H "$CRUMB" -w "%{http_code}" -X POST http://localhost/createItem)
if [ "$ACTUAL_STATUS_CODE_WITHOUT_AUTH" != "403" ]; then
    echo Expected status 403, but got $ACTUAL_STATUS_CODE_WITHOUT_AUTH
    exit 122
fi
# Expect code 400 Bad Request because we are authorized but don't pass the required parameters
ACTUAL_STATUS_CODE_WITH_AUTH=$(curl --user admin:$ADMIN_PASSWORD -X POST -s -o /dev/null --cookie "$COOKIEJAR" -H "$CRUMB" -w "%{http_code}" http://localhost/createItem)
if [ "$ACTUAL_STATUS_CODE_WITH_AUTH" != "400" ]; then
    echo Expected status 400, but got $ACTUAL_STATUS_CODE_WITH_AUTH
    exit 123
fi

JENKINS_USERNAME=admin JENKINS_PASSWORD=$ADMIN_PASSWORD ./cx-server stop
./cx-server remove

# cleanup
if [ ! "$GITHUB_ACTIONS" = true ] ; then
    rm -f cx-server server.cfg custom-environment.list
    echo "Modified your git repo, you might want to do a git checkout before re-running."
fi
