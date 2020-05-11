#!/usr/bin/env bash

set -ex

mkdir -p bin
wget -O bin/piper --quiet https://github.com/SAP/jenkins-library/releases/latest/download/piper_master
chmod +x bin/piper
echo "::add-path::${PWD}/bin"
echo "##vso[task.setvariable variable=PATH]${PATH}:${PWD}/bin"
