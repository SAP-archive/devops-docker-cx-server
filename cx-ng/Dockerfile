ARG JVM_VERSION=11.0.6.0.1
ARG MAVEN_VERSION=3.6.3
ARG NODE_VERSION=v12.16.1

FROM debian:buster as builder

ARG JVM_VERSION
ARG MAVEN_VERSION
ARG NODE_VERSION

ADD https://github.com/SAP/SapMachine/releases/download/sapmachine-${JVM_VERSION}/sapmachine-jdk-${JVM_VERSION}_linux-x64_bin.tar.gz /jdk.tgz
RUN tar xzf jdk.tgz -C /opt
ADD http://apache.lauf-forum.at/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz /maven.tgz
RUN tar xzf /maven.tgz -C /opt
ADD https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.gz /node.tgz
RUN tar xzf /node.tgz -C /opt
ADD https://github.com/nektos/act/releases/download/v0.2.6/act_Linux_x86_64.tar.gz /act.tgz
RUN mkdir -p /opt/act; tar xzf /act.tgz -C /opt/act
RUN mkdir -p /opt/piper
ADD https://github.com/SAP/jenkins-library/releases/latest/download/piper_master /opt/piper/piper

FROM debian:buster

ARG JVM_VERSION
ARG MAVEN_VERSION
ARG NODE_VERSION

RUN apt-get -y update; apt-get -y dist-upgrade; apt-get -y install chromium firefox-esr wget curl
COPY --from=builder /opt /opt
RUN mkdir /home/user && echo "user:x:1002:1002:user:/home/user:/bin/bash" >> /etc/passwd
RUN chown -R user /home/user; chmod +x /opt/piper/piper
USER user
RUN echo "PATH=/opt/piper:/opt/act:/opt/apache-maven-$MAVEN_VERSION/bin:/opt/node-$NODE_VERSION-linux-x64/bin:/opt/sapmachine-jdk-$JVM_VERSION/bin:$PATH" >> /home/user/.bashrc
WORKDIR /home/user
