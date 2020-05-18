FROM jenkins/jenkins:lts

USER root

ENV DOCKERVERSION=18.06.3-ce
ENV MAVENVERSION=3.6.3

RUN curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKERVERSION}.tgz \
  && tar xzvf docker-${DOCKERVERSION}.tgz --strip 1 \
                 -C /usr/local/bin docker/docker \
  && rm docker-${DOCKERVERSION}.tgz

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl

RUN curl -LO https://downloads.apache.org/maven/maven-3/${MAVENVERSION}/binaries/apache-maven-${MAVENVERSION}-bin.tar.gz \
    && tar xzvf apache-maven-${MAVENVERSION}-bin.tar.gz -C /opt/ \
    && mv /opt/apache-maven-${MAVENVERSION} /opt/apache-maven \
    && rm apache-maven-${MAVENVERSION}-bin.tar.gz
    
ENV PATH=/opt/apache-maven/bin:$PATH

ENV _JAVA_OPTIONS=-Djdk.net.URLClassPath.disableClassPathURLCheck=true
