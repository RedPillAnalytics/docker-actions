FROM gradle:latest
USER root

ARG gradleUserHome="/github/workspace/.gradle"
ENV GRADLE_USER_HOME=$gradeUserHome

# Run the Update
RUN apt-get update && apt-get upgrade -y

ENTRYPOINT ["/usr/bin/gradle"]