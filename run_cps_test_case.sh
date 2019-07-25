docker build -t ppiper/jenkins-master jenkins-master
docker build -t ppiper/jenkinsfile-runner jenkinsfile-runner
pushd jenkinsfile-runner
docker run -v //var/run/docker.sock:/var/run/docker.sock -v $(pwd):/workspace -v /tmp \
 -e CX_INFRA_IT_CF_PASSWORD -e CX_INFRA_IT_CF_USERNAME -e BRANCH_NAME=master \
 -e CASC_JENKINS_CONFIG=/workspace/jenkins.yml -e HOST=$(hostname) \
 ppiper/jenkinsfile-runner
popd
