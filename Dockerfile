FROM  centos:latest
# Setting Maven Version that needs to be installed
ARG MAVEN_VERSION=3.5.4

RUN yum update -y && \
    yum install -y which && \
    yum clean all

RUN curl -L -O https://corretto.aws/downloads/latest/amazon-corretto-11-x64-linux-jdk.rpm
RUN rpm -vi amazon-corretto-11-x64-linux-jdk.rpm
# RUN yum install java-11-openjdk-devel -y
# RUN yum install java-11-openjdk -y

# Maven
RUN curl -fsSL https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share \
    && mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
    && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_VERSION=${MAVEN_VERSION}
ENV M2_HOME /usr/share/maven
ENV maven.home $M2_HOME
ENV M2 $M2_HOME/bin
ENV PATH $M2:$PATH

RUN curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.7.0-x86_64.rpm
RUN rpm -vi filebeat-7.7.0-x86_64.rpm
RUN filebeat modules enable system
RUN chmod go-w /etc/filebeat/filebeat.yml

RUN systemctl enable filebeat

RUN cd home
RUN mkdir -p /spring-boot-h2-crud

WORKDIR /spring-boot-h2-crud

COPY . .



