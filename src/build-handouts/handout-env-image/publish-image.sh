#!/bin/bash

IMAGE_NAME="rays2/gt-handout-env"

./build-image.sh

docker push "$IMAGE_NAME" --all-tags
