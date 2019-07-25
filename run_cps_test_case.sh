docker build -t ppiper/jenkins-master jenkins-master
pushd jenkinsfile-runner
docker-compose --file docker-compose.test.yml build
docker-compose --file docker-compose.test.yml run sut

popd
