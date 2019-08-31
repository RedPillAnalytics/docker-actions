FROM ubuntu:latest
USER root

ARG envVar=environemnt-variable
ENV ENV_VAR=$envVar

# Run the Update
RUN apt-get update && apt-get upgrade -y
