FROM jenkins/jnlp-slave:3.27-1-alpine
USER root

RUN apk add --no-cache curl

# add group & user
RUN adduser -D -h /home/piper -u 1000 piper -s /bin/bash

USER piper
WORKDIR /home/piper
