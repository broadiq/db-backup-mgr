FROM postgres:13.1-alpine


#FROM openjdk:8-jdk-alpine
#FROM anapsix/alpine-java:8_jdk

#FROM openjdk:latest

MAINTAINER John S. Lutz <jlutz@broadiq.com>

ENV SERVER_PORT 8077 

RUN apk update
RUN apk add mysql mysql-client
RUN apk add mongodb-tools

ENV LANG C.UTF-8

# add a simple script that can auto-detect the appropriate JAVA_HOME value
# based on whether the JDK or only the JRE is installed
RUN { \
		echo '#!/bin/sh'; \
		echo 'set -e'; \
		echo; \
		echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
	} > /usr/local/bin/docker-java-home \
	&& chmod +x /usr/local/bin/docker-java-home
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin

ENV JAVA_VERSION 8u131
ENV JAVA_ALPINE_VERSION 8.242.08-r0

RUN set -x \
        && apk add --no-cache openjdk8 \
        && [ "$JAVA_HOME" = "$(docker-java-home)" ]


#RUN set -x \
#	&& apk add --no-cache \
#		openjdk8="$JAVA_ALPINE_VERSION" \
#	&& [ "$JAVA_HOME" = "$(docker-java-home)" ]



RUN mkdir -p /briq/mysql/data
RUN mkdir -p /briq/mysql/scripts

RUN mkdir -p /briq/mongodb/data
RUN mkdir -p /briq/mongodb/scripts

RUN mkdir -p /briq/postgresql/data
RUN mkdir -p /briq/postgresql/scripts

ADD scripts/mysql/mysqldump.sh /briq/mysql/scripts
ADD scripts/mysql/mysqlrestore.sh /briq/mysql/scripts
ADD scripts/mysql/mysqltar.sh /briq/mysql/scripts
ADD scripts/mysql/mysqluntar.sh /briq/mysql/scripts
RUN chmod +x /briq/mysql/scripts/*

ADD scripts/mongodb/mongodump.sh /briq/mongodb/scripts
ADD scripts/mongodb/mongorestore.sh /briq/mongodb/scripts
ADD scripts/mongodb/mongotar.sh /briq/mongodb/scripts
ADD scripts/mongodb/mongountar.sh /briq/mongodb/scripts

RUN chmod +x /briq/mongodb/scripts/*

ADD scripts/postgresql/postgresqldump.sh /briq/postgresql/scripts
ADD scripts/postgresql/postgresqlrestore.sh /briq/postgresql/scripts
ADD scripts/postgresql/postgresqltar.sh /briq/postgresql/scripts
ADD scripts/postgresql/postgresqluntar.sh /briq/postgresql/scripts

RUN chmod +x /briq/postgresql/scripts/*

ADD NfsManager-0.0.1-SNAPSHOT.jar app.jar

EXPOSE $SERVER_PORT

ENTRYPOINT ["java","-Xmx256m", "-Djava.security.egd=file:/dev/./urandom","-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005","-jar","/app.jar"]
#ENTRYPOINT ["java","-Xmx256m", "-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
