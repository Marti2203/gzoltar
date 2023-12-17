FROM ubuntu:20.04

LABEL maintainer="Martin Mirchev <mmirchev@comp.nus.edu.sg>"

#############################################################################
# Requirements
#############################################################################

RUN \
  apt-get update -y && \
  apt-get install software-properties-common -y && \
  apt-get update -y && \
  apt-get install -y openjdk-11-jdk \
                git \
                build-essential \
				subversion \
				perl \
				curl \
        maven \
        gradle \
        ant \
				unzip \
				cpanminus \
				make \
                && \
  rm -rf /var/lib/apt/lists/*

# Java version
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64

# Timezone
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR /

RUN mkdir /gzoltar

COPY . /gzoltar

WORKDIR /gzoltar

RUN mvn package dependency:copy-dependencies

RUN mkdir /gzoltar/libs

RUN  wget "https://repo1.maven.org/maven2/junit/junit/4.12/junit-4.12.jar" -O "/gzoltar/libs/junit.jar"
RUN  wget -np -nv "https://repo1.maven.org/maven2/org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.jar" -O "/gzoltar/libs/hamcrest-core.jar"
