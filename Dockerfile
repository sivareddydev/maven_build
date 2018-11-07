from centos:7


RUN mkdir -p /tools /tools-copy

RUN curl --fail --silent --location --retry 3 \
     http://192.168.56.102:8081/repository/ftp/jdk-8u191-linux-x64.tar.gz  \
    | gunzip \ 
    | tar -x -C /tools-copy\
    && mv /tools-copy/jdk1.8.0_191 /tools-copy/java \
    && chown root /tools-copy

RUN curl --fail --silent --location --retry 3 \
    http://192.168.56.102:8081/repository/ftp/apache-maven-3.5.4-bin.tar.gz \
    | gunzip \
    | tar -x -C /tools-copy \
    && mv /tools-copy/apache-maven-3.5.4 /tools-copy/maven \
    && chown root /tools-copy

RUN groupadd -g 30051 jenkins \
    && useradd -u 2000 -g 30051 jenkins \
    && chown -R jenkins:jenkins /tools /tools-copy

USER jenkins

VOLUME "/tools"

CMD cp -rv /tools-copy/* /tools/ 
