#!/bin/bash

# configuration
BUILD_DIR="../../build"
MAIN_FILE="syllabus.tex"

cd src/handouts
rm -rf "$BUILD_DIR"/*

if [ ! -d "${BUILD_DIR}" ]; then
  mkdir -p "$BUILD_DIR"
fi

echo "Building ${MAIN_FILE} silently. Only errors will show here."
for _ in {1..3}; do
  # slient if no errors
  # reference: https://tex.stackexchange.com/a/459470
  xelatex -output-directory="$BUILD_DIR" -halt-on-error "$MAIN_FILE" 2>&1 |
    grep '^!.*' -A200 --color=always
done

if [ "$?" -ne "0" ]; then
  # grep gets nothing, so no error
  echo "Done!"
  exit 0
fi

exit 1
