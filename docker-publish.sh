#!/bin/bash
INPUT_USERNAME=$1
INPUT_PASSWORD=$2
INPUT_SNAPSHOT=$3
INPUT_REGISTRY=$4
INPUT_NAME=`echo $GITHUB_REPOSITORY | tr '[:upper:]' '[:lower:]'`

# echo "Repository: ${INPUT_NAME}"

if [ -z "${INPUT_USERNAME}" ]; then
  echo "Unable to find the docker repository username."
  exit 1
fi

if [ -z "${INPUT_PASSWORD}" ]; then
  echo "Unable to find the docker repository password."
  exit 1
fi

# If a PR, then use the merging branch
[[ "$GITHUB_HEAD_REF" ]] && BRANCH="${GITHUB_HEAD_REF}" || BRANCH=$(echo ${GITHUB_REF} | sed -e "s/refs\/heads\///g")

if [ "${BRANCH}" == "master" ]; then
  BRANCH="latest"
fi;

# if contains /refs/tags/
if [ $(echo ${GITHUB_REF} | sed -e "s/refs\/tags\///g") != ${GITHUB_REF} ]; then
  BRANCH="latest"
fi;

# echo "Branch: ${BRANCH}"

DOCKERNAME="${INPUT_NAME}:${BRANCH}"

echo "Docker Name: ${DOCKERNAME}"

# CUSTOMDOCKERFILE=""
# if [ ! -z "${INPUT_DOCKERFILE}" ]; then
#   CUSTOMDOCKERFILE="-f ${INPUT_DOCKERFILE}"
# fi

docker login -u ${INPUT_USERNAME} -p ${INPUT_PASSWORD} ${INPUT_REGISTRY}

# go ahead and build and create both tags. Doesn't cost anything
SHA_DOCKER_NAME="${INPUT_NAME}:${GITHUB_SHA}"
docker build $CUSTOMDOCKERFILE -t ${DOCKERNAME} -t ${SHA_DOCKER_NAME} .

docker push ${DOCKERNAME}

# if either snapshot or a PR, then push the SHA version
if [ "${INPUT_SNAPSHOT}" == "true" ]; then
  docker push ${SHA_DOCKER_NAME}
fi

docker logout