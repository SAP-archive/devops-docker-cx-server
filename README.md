# CX Server Dockerfiles

[![REUSE status](https://api.reuse.software/badge/github.com/SAP/devops-docker-cx-server)](https://api.reuse.software/info/github.com/SAP/devops-docker-cx-server)

## Deprecation Note
devops-docker-cx-server is deprecated and won't be developed or maintained further. The repository will be sunsetted soon.
If somebody outside in the community would like to take over this repository, feel free to contact us.

A manual, how to setup your Jenkins manually, can be found here: [Jenkins Setup](https://www.project-piper.io/infrastructure/customjenkins/)

## Description

The CX Server is a collection of [_Dockerfiles_](https://docs.docker.com/engine/reference/builder/) for images that can be used in _Continuous Delivery_ (CD) pipelines for SAP development projects.
The images are optimized for use with project ["Piper"](https://github.com/SAP/jenkins-library) on [Jenkins](https://jenkins.io/).
Docker containers simplify your CD tool setup, encapsulating tools and environments that are required to execute pipeline steps.

If you want to learn how to use project "Piper" please have a look at [the documentation](https://github.com/SAP/jenkins-library/blob/master/README.md).
Introductory material and a lot of SAP scenarios not covered by project "Piper" are described in our [Continuous Integration Best Practices](https://developers.sap.com/tutorials/ci-best-practices-intro.html).

This repository contains Dockerfiles that are designed to run project "Piper" pipelines.
Nevertheless, they can also be used flexibly in any custom environment and automation process.

For detailed usage information please check the README.md in the corresponding folder.

### Docker Images

The following images are published on [hub.docker.com](https://hub.docker.com/search?q=ppiper&type=image):

| Name | Description | Docker Image |
|------|-------------|------|
| Jenkins | Preconfigured Jenkins to run project "Piper" pipelines. | [ppiper/jenkins-master](https://hub.docker.com/r/ppiper/jenkins-master) |
| Jenkinsfile Runner| [Jenkinsfile Runner](https://github.com/jenkinsci/jenkinsfile-runner) based on `ppiper/jenkins-master`, allows running a `Jenkinsfile` without a long-running, stateful Jenkins master. | [ppiper/jenkinsfile-runner](https://hub.docker.com/r/ppiper/jenkinsfile-runner) |
| Jenkinsfile Runner GitHub Action | [GitHub Action](https://github.com/features/actions) for using the [Jenkinsfile runner](jenkinsfile-runner) | [jenkinsfile-runner-github-action](jenkinsfile-runner-github-action) |
| Life Cycle Container| Sidecar image for life-cycle management of the cx-server|[ppiper/cx-server-companion](https://hub.docker.com/r/ppiper/cx-server-companion)|

#### Versioning

All images have a Docker tag `latest`.
Individual images may provide additional tags corresponding to releases.

Existing releases are listed on the [GitHub releases page](https://github.com/SAP/devops-docker-cx-server/releases).
Official releases follow the pattern `v{VersionNumber}`.

Developer documentation for releases is available in the [release documentation document](docs/development/how-to-release.md).

Information on updating the Jenkins master including the bundled plugins is available in [the respective section of the operations guide](https://github.com/SAP/devops-docker-cx-server/blob/master/docs/operations/cx-server-operations-guide.md#update-image).

## General Requirements

A [Docker](https://www.docker.com/) environment is needed to build and run Docker images.
You should be familiar with basic Docker commands to build and run these images.
In case you need to fetch the Dockerfiles and this project's sources to build them locally, a [Git client](https://git-scm.com/) is required.

Each individual Dockerfile may have additional requirements. Those requirements are documented with each Dockerfile.

## Download and Installation

To download and install Docker please follow the instructions at the [Docker website](https://www.docker.com/get-started) according your operating system.

You can consume these images in three different flavors:

1. Build locally and run

    Clone this repository, change directories to the desired Dockerfile and build it:

    ````
    git clone https://github.com/SAP/devops-docker-cx-server
    cd devops-docker-cx-server/<specific-image>
    docker build .
    docker run ...
    ````

    Specific instructions how to run the containers are stored within the same directory.

2. Pull from hub.docker.com

    We build the Dockerfiles for your convenience and store them on https://hub.docker.com/.

    ````
    docker pull <image-name>:<version>
    docker run ...
    ````

3. Via project "Piper"

    In case you are using [project "Piper"](https://sap.github.io/jenkins-library/) you can configure certain steps
    to use docker images instead of the local Jenkins environment. These steps will automatically pull and run these
    images.

### Setting up Jenkins Server
The `cx-server` is a toolkit that is developed to manage the lifecycle of the Jenkins server.
In order to use the toolkit, you need a file named `cx-server` and a configuration file `server.cfg`.
You can generate these files using the docker command

```sh
docker run -it --rm -u $(id -u):$(id -g) -v "${PWD}":/cx-server/mount/ ppiper/cx-server-companion:latest init-cx-server
```

Once the files are generated in the current directory, you can launch the below command to start the Jenkins server.

```sh
./cx-server start
```

If you would like to customize the Jenkins, [the operations guide](https://github.com/SAP/devops-docker-cx-server/blob/master/docs/operations/cx-server-operations-guide.md) will provide more information on this along with the lifecycle management of the Jenkins.

## How to obtain support

Feel free to open new issues for feature requests, bugs or general feedback on
the [GitHub issues page of this project][devops-docker-cx-server-issues].

## Contributing

Read and understand our [contribution guidelines][contribution]
before opening a pull request.

[devops-docker-cx-server-issues]: https://github.com/SAP/devops-docker-cx-server/issues
[contribution]: https://github.com/SAP/devops-docker-cx-server/blob/master/CONTRIBUTING.md

## Licensing

Copyright 2017-2021 SAP SE or an SAP affiliate company and devops-docker-cx-server contributors. Please see our [LICENSE](LICENSE) for copyright and license information. Detailed information including third-party components and their licensing/copyright information is available [via the REUSE tool](https://api.reuse.software/info/github.com/SAP/devops-docker-cx-server).
