#!/bin/bash
set -u -o pipefail

function die() {
  if (( ${#@} > 0 )); then
    echo "$@" >&2
  fi
  echo
  echo "FAILED"
  exit 1
}

cd "$(dirname "$BASH_SOURCE")" || die

curl -O https://repo.jenkins-ci.org/releases/io/jenkins/tools/custom-war-packager/custom-war-packager-cli/1.7/custom-war-packager-cli-1.7-jar-with-dependencies.jar
CUSTOM_WAR_PACKAGER_CLI_JAR="${PWD}/custom-war-packager-cli-1.7-jar-with-dependencies.jar"

echo "Building jenkinsfile-runner-base image"
java -jar "$CUSTOM_WAR_PACKAGER_CLI_JAR" -configPath "packager-config.yml" || die
