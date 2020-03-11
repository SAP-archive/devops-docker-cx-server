#!/bin/bash
set -o nounset
set -o errexit

if [[ "$#" -ne 2 ]]; then
	echo "Usage: $(basename "$0") my/tag my-dockerfile-dir"
	exit 1
fi

TAG=$1
DIR=$2

# Create a backup of the image to allow rollback in case of failure
docker pull ${TAG}:latest
docker tag ${TAG}:latest ${TAG}:backup-of-latest

# Build the Release Candidate
docker build ${DIR} --tag ${TAG}:RC
