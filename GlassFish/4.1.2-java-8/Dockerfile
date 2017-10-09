# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS HEADER.
# 
# Copyright (c) 2017 Oracle and/or its affiliates. All rights reserved.
# 
# GlassFish on Docker with Oracle Linux and OpenJDK
FROM oraclelinux:7-slim

# Maintainer
MAINTAINER Konstantin Volkov<kvolkov@ibs.ru>

# Set environment variables and default password for user 'admin'
ENV GLASSFISH_PKG=glassfish-4.1.2.zip \
    GLASSFISH_URL=http://download.oracle.com/glassfish/4.1.2/release/glassfish-4.1.2.zip \
    GLASSFISH_UNPACK_DIR=/glassfish4 \
    GLASSFISH_HOME=/glassfish \
    MD5=9a37928ea6e54334101b8a89e03a8d7d \
    PATH=$PATH:/glassfish/bin \
    JAVA_HOME=/usr/lib/jvm/java-8-oracle/

# Install packages, download and extract GlassFish
# Setup password file
# Enable DAS



RUN yum -y install unzip wget less && \
    wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
      http://download.oracle.com/otn-pub/java/jdk/8u144-b01/090f390dda5b47b9b721c7dfaa008135/jre-8u144-linux-x64.rpm && \
    yum -y localinstall ./jre-8u144-linux-x64.rpm && \
    rm ./jre-8u144-linux-x64.rpm && \
    curl -O $GLASSFISH_URL && \
    echo "$MD5 *$GLASSFISH_PKG" | md5sum -c - && \
    unzip -o $GLASSFISH_PKG && \
    rm -f $GLASSFISH_PKG && \
    mv $GLASSFISH_UNPACK_DIR $GLASSFISH_HOME && \
    yum -y remove unzip && \
    yum clean all

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# Ports being exposed
EXPOSE 4848 8080 8181

# Start asadmin console and the domain
CMD ["asadmin", "start-domain", "-v"]

#открыть ssh

