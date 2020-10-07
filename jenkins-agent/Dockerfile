FROM openjdk:8-jre-slim

ENV JENKINS_HOME /var/jenkins_home
ENV MAVEN_VERSION 3.6.3

# https://github.com/hadolint/hadolint/wiki/DL4006
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        openssh-client \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg2 \
        software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    apt-key fingerprint 0EBFCD88 && \
    add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/debian \
       $(lsb_release -cs) \
       stable" && \
    apt-get update && \
    apt-get -y --no-install-recommends install docker-ce && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/* && \
    mkdir -p /usr/share/maven && pushd /usr/share/maven && \
    curl https://apache.lauf-forum.at/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz | tar xz --strip-components=1 && \
    popd && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

# add group & user
RUN addgroup -gid 1000 jenkins && \
    useradd jenkins -d "$JENKINS_HOME" --uid 1000 --gid 1000 --shell /bin/bash --create-home

VOLUME /var/jenkins_home

USER jenkins
