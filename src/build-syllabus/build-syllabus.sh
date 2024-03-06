#!/bin/bash
# NOTICE: This script only works in Linux. In Windows, please run
# this script in the Windwos Subsystem Linux (WSL) 2

# configuration
IMAGE_NAME="gt-syllabus-env"
IMAGE_TAG=latest
CONTAINER_NAME="gt-syllabus"
ALWAYS_REBUILD_IMAGE="y" # y/n

# get required variables to build the handotus
REPO_ROOT="$(cd ../../ && pwd)"

CORRECT_DIR=build-syllabus
if ! [ "$(basename $(pwd))" = "$CORRECT_DIR" ]; then
  echo Please run this script in the directory that
  echo contains this script, or modify the variable
  echo '"CORRECT_DIR" in this script.'
  exit 1
fi

# build the image first if it is not present
IMAGE_LIST="$(docker images "${IMAGE_NAME}" --format "{{.Repository}}:{{.Tag}}")"
if [ ! -z "$IMAGE_LIST" ] || [ "$ALWAYS_REBUILD_IMAGE" -eq "y" ]; then
  ./build-image.sh
fi

docker run --rm -it \
  --name "$CONTAINER_NAME" \
  --mount type=bind,source="${REPO_ROOT}/src/handouts",target=/app/src/handouts,readonly \
  --mount type=bind,source="${REPO_ROOT}/build",target=/app/build \
  --hostname "$CONTAINER_NAME" \
  "${IMAGE_NAME}:${IMAGE_TAG}"