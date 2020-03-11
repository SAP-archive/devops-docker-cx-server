#!/bin/bash
set -o nounset
set -o errexit

if [[ "$#" -ne 1 ]]; then
	echo "Usage: $(basename "$0") my/tag my-dockerfile-dir"
	exit 1
fi

TAG=$1

docker tag ${TAG}:RC ${TAG}:latest
docker push ${TAG}:backup-of-latest
docker push ${TAG}:latest
