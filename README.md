# docker-build
A template repository for building docker images and publishing them to Docker Hub. At the moment, this uses GitHub Actions, but not sure of the longterm direction.

The following Github *secrets* are used as part of the build and publish process:

**DOCKER_USER**: Used for loging into DockerHub.

**DOCKER_PASSWORD**: Used for loging into DockerHub.

**DOCKER_OWNER**: Used for pushing images to DockerHub.

