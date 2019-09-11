# Go ahead and start with a JDK
FROM adoptopenjdk:8-jdk-hotspot
USER root

# Sample environment variables with Confluent
ENV CONFLUENT_HOME=/confluent
ENV CONFLUENT_BASE=5.3
ENV CONFLUENT_VERSION=5.3.0
ENV SCALA_VERSION=2.12
ENV CONFLUENT_CURRENT=/confluent/data
ENV PATH "$PATH:.:/confluent/bin"

# Run the Update
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install wget curl zip -y

# Example install of Confluent platform
RUN curl -O http://packages.confluent.io/archive/${CONFLUENT_BASE}/confluent-community-${CONFLUENT_VERSION}-${SCALA_VERSION}.zip \
    && unzip confluent-community-${CONFLUENT_VERSION}-${SCALA_VERSION}.zip \
    && mv confluent-${CONFLUENT_VERSION} /confluent \
    # install confluent cli
    && curl -L https://cnfl.io/cli | sh -s -- -b /usr/local/bin \
    && mkdir -p ${CONFLUENT_CURRENT} \
    && confluent update
