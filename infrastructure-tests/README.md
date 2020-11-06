# Infrastructure testing

This directory contains testing code for the infrastructure that is defined in the Dockerfiles.

## What it does

* Build the images from source
* Boot a Jenkins master using the life-cycle management script, with the built images
* Create and trigger a Jenkins job, wait for it to be green

## Running as a Service

See `.github/workflows/tests.yml` file for configuration.

## Running locally

Docker is required, and at least 4 GB of memory assigned to Docker.

```bash
./runTests.sh
```
