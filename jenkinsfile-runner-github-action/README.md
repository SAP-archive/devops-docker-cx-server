# Jenkinsfile Runner GitHub Action

This Action allows you to run Project Piper based pipelines such as [SAP Cloud SDK Pipeline](https://github.com/sap/cloud-s4-sdk-pipeline) on GitHub Actions.

## Example

Create a file called `.github/workflows/main.yml` with the following content in your project and enable GitHub Actions

```yaml
on: push
name: Build project
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: Run Cloud SDK Pipeline
      uses: SAP/devops-docker-cx-server/jenkinsfile-runner-github-action@master
```

In addition, you'll need a file called `jenkins.yml` in the root of your project where the required Jenkins libraries are configured, like in this example:

```yaml
jenkins:
  numExecutors: 10
unclassified:
  globallibraries:
    libraries:
    - defaultVersion: "master"
      name: "s4sdk-pipeline-library"
      retriever:
        modernSCM:
          scm:
            git:
              remote: "https://github.com/SAP/cloud-s4-sdk-pipeline-lib.git"
    - defaultVersion: "master"
      name: "piper-library-os"
      retriever:
        modernSCM:
          scm:
            git:
              remote: "https://github.com/SAP/jenkins-library.git"
```

## License

Copyright (c) 2018 SAP SE or an SAP affiliate company. All rights reserved.
This file is licensed under the Apache Software License, v. 2 except as noted
otherwise in the [LICENSE file](https://github.com/SAP/devops-docker-cx-server/blob/master/LICENSE).

Please note that Docker images can contain other software which may be licensed under different licenses. This License file is also included in the Docker image. For any usage of built Docker images please make sure to check the licenses of the artifacts contained in the images.

This image contains [Jenkinsfile Runner](https://github.com/jenkinsci/jenkinsfile-runner), which is licensed under the [MIT license](https://github.com/jenkinsci/jenkinsfile-runner/blob/9f41f51b6dc320b9dd5c0fa6d81f179518597d37/pom.xml#L43).

This GitHub Action was inspired by [jenkinsci/jenkinsfile-runner-github-actions](https://github.com/jenkinsci/jenkinsfile-runner-github-actions), which is available under Apache 2 license.
