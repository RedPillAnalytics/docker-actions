FROM gradle:latest
USER root

ARG gradleUserHome=.gradle
ENV GRADLE_USER_HOME=$gradleUserHome

# Run the Update
RUN apt-get update && apt-get upgrade -y

ENTRYPOINT ["/usr/bin/gradle"]