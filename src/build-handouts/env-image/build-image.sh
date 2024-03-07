#!/bin/bash
# NOTICE: This script only works in Linux. In Windows, please run
# this script in the Windwos Subsystem Linux (WSL) 2

# configuration
UBUNTU_IMAGE_TAG="jammy-20240212"

CORRECT_DIR=env-image
if ! [ "$(basename $(pwd))" = "$CORRECT_DIR" ]; then
  echo Please run this script in the directory that
  echo contains this script, or modify the variable
  echo '"CORRECT_DIR" in this script.'
  exit 1
fi

# get variables required for building the image,
# where "3" means going up three directories from the CWD
REPO_ROOT="$(cd ../../../ && pwd)"
IMAGE_NAME="rays2/gt-handout-env"
VERSION=$(cat "${REPO_ROOT}/src/handouts/version.txt")
PACKAGES="$(
  grep 'id="\?package-list' -A3 "${REPO_ROOT}/README.md" |
    tail -1 |
    xargs echo
)"

# remove_old_images
IMAGE_LIST="$(docker images "${IMAGE_NAME}" --format "{{.Repository}}:{{.Tag}}")"
if [ ! -z "$IMAGE_LIST" ]; then
  docker rmi $IMAGE_LIST
fi

docker build \
  --tag "${IMAGE_NAME}:latest" \
  --tag "${IMAGE_NAME}:${VERSION}" \
  --build-arg UBUNTU_IMAGE_TAG="$UBUNTU_IMAGE_TAG" \
  --build-arg PACKAGES="$PACKAGES" \
  --build-arg UID_USER=$(id -u) \
  --build-arg GID_USER=$(id -g) \
  .
