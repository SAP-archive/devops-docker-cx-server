# Project "Piper" GitHub Actions Runtime Environment

Dockerfile for running the [Project "Piper" Action](https://github.com/SAP/project-piper-action) locally using [act](https://github.com/nektos/act)

**NOTE:** This is a Proof of Concept, depending on what your GitHub Actions workflow does, the image will not work out of the box.
The image tries to mirror [GitHub's hosted runner image](https://github.com/actions/virtual-environments/blob/master/images/linux/Ubuntu1804-README.md) to a very limited scope.
The goal is to provide an environment capable of running workflows based on project "Piper", not more.
It contains a user called `actions` with uid `1000`.
Additonally, it includes a JDK, Maven and NodeJs.
Extend the Dockerfile as you see fit and build your own image.

## Usage

* Install Docker Desktop, if you don't have already
* Install act from https://github.com/nektos/act
* Build the image: `docker build -t myruntime .`
* Run using: `act -P ubuntu-18.04=myruntime` in the root of your project with a project "Piper"-based workflow

The version of the provided JDK, Maven and NodeJs may be modified using [build arguments](https://docs.docker.com/engine/reference/commandline/build/#set-build-time-variables---build-arg).
As an example, using another NodeJs version can be done using `docker build --build-arg=NODE_VERSION=v13.0.0 -t myruntime .`.

Available arguments:

- `JVM_VERSION`
- `MAVEN_VERSION`
- `NODE_VERSION`

## License

Copyright (c) 2018 SAP SE or an SAP affiliate company. All rights reserved.
This file is licensed under the Apache Software License, v. 2 except as noted
otherwise in the [LICENSE file](https://github.com/SAP/devops-docker-cx-server/blob/master/LICENSE).

Please note that Docker images can contain other software which may be licensed under different licenses. This License file is also included in the Docker image. For any usage of built Docker images please make sure to check the licenses of the artifacts contained in the images.

Amongst others, this image includes:

- [SapMachine](https://sap.github.io/SapMachine/)
- [Maven](http://maven.apache.org/)
- [Node.js](https://nodejs.org/en/)
