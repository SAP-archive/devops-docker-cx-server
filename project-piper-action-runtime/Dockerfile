ARG JVM_VERSION=11.0.7
ARG MAVEN_VERSION=3.6.3
ARG NODE_VERSION=v12.16.2

FROM debian:buster-slim as builder

ARG JVM_VERSION
ARG MAVEN_VERSION
ARG NODE_VERSION

ADD https://github.com/SAP/SapMachine/releases/download/sapmachine-${JVM_VERSION}/sapmachine-jdk-${JVM_VERSION}_linux-x64_bin.tar.gz /jdk.tgz
RUN tar xzf jdk.tgz -C /opt
ADD http://apache.lauf-forum.at/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz /maven.tgz
RUN tar xzf /maven.tgz -C /opt
ADD https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.gz /node.tgz
RUN tar xzf /node.tgz -C /opt

FROM debian:buster-slim

ARG JVM_VERSION
ARG MAVEN_VERSION
ARG NODE_VERSION

# hadolint ignore=DL3008
RUN apt-get -y update \
 && apt-get -y dist-upgrade \
 && apt-get -y --no-install-recommends install wget curl ca-certificates unzip \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir -p /home/actions && echo "actions:x:1000:1000:actions:/home/actions:/bin/bash" >> /etc/passwd \
 && chown -R actions /home/actions \
 && echo "PATH=/opt/apache-maven-$MAVEN_VERSION/bin:/opt/node-$NODE_VERSION-linux-x64/bin:/opt/sapmachine-jdk-$JVM_VERSION/bin:$PATH" >> /home/actions/.bashrc

WORKDIR /home/actions

ENV PATH=/opt/apache-maven-$MAVEN_VERSION/bin:/opt/node-$NODE_VERSION-linux-x64/bin:/opt/sapmachine-jdk-$JVM_VERSION/bin:$PATH
ENV RUNNER_TEMP=/tmp

COPY --from=builder /opt /opt
