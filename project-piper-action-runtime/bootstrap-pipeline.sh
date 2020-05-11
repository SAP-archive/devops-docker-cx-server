#!/usr/bin/env bash

set -ex

mkdir -p bin
wget -O bin/piper --quiet https://github.com/SAP/jenkins-library/releases/latest/download/piper_master
chmod +x bin/piper
echo "::add-path::${PWD}/bin"
echo "##vso[task.setvariable variable=PATH]${PATH}:${PWD}/bin"

mkdir -p .pipeline

if [ ! -f .pipeline/01_prepareVersion.sh ]; then
    echo "piper artifactPrepareVersion" > .pipeline/01_prepareVersion.sh
    chmod +x .pipeline/01_prepareVersion.sh
fi

if [ ! -f .pipeline/02_build.sh ]; then
    echo "piper mavenBuild" > .pipeline/02_build.sh
    chmod +x .pipeline/02_build.sh
fi

if [ ! -f .pipeline/04_staticChecks.sh ]; then
    echo "piper mavenExecuteStaticCodeChecks" > .pipeline/04_staticChecks.sh
    chmod +x .pipeline/04_staticChecks.sh
fi

