#!/bin/bash
# NOTICE: This script only works in Linux. In Windows, please run
# build-handouts-windows.bat with CMD.

# configuration
IMAGE_NAME="rays2/gt-handout-env"
IMAGE_TAG=latest
CONTAINER_NAME="gt-handout"
REPO_ROOT="$(cd ../../ && pwd)" # absolute path
BUILD_DIR="build"
BUILD_PATH="${REPO_ROOT}/${BUILD_DIR}"
ALWAYS_REBUILD_IMAGE="n"

CORRECT_DIR=build-handouts
if ! [ "$(basename $(pwd))" = "$CORRECT_DIR" ]; then
  echo Please run this script in the directory that
  echo contains this script, or modify the variable
  echo '"CORRECT_DIR" in this script.'
  exit 1
fi

mkdir -p "$BUILD_PATH"

if [ "$ALWAYS_REBUILD_IMAGE" = "y" ]; then
  cd env-image
  ./build-image.sh
fi

docker run --rm -it \
  --name "$CONTAINER_NAME" \
  --mount type=bind,source="${REPO_ROOT}/src/handouts",target=/app/src/handouts,readonly \
  --mount type=bind,source="$BUILD_PATH",target=/app/build \
  --hostname "$CONTAINER_NAME" \
  "${IMAGE_NAME}:${IMAGE_TAG}"
