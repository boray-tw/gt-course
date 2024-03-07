#!/bin/bash

# configuration
BUILD_DIR="../../build"
MAIN_FILE="main.tex"

cd src/handouts

if [ ! -d "${BUILD_DIR}" ]; then
  mkdir -p "$BUILD_DIR"
else
  rm -rf "${BUILD_DIR}/${MAIN_FILE%.tex}"
fi

echo "Building ${MAIN_FILE} silently. Only errors will show here."
for _ in {1..3}; do
  # slient if no errors
  # reference: https://tex.stackexchange.com/a/459470
  pdflatex -output-directory="$BUILD_DIR" -halt-on-error main.tex 2>&1 |
    grep '^!.*' -A200 --color=always
done

if [ "$?" -ne "0" ]; then
  # grep gets nothing, so no error
  echo "Done!"
  exit 0
fi

exit 1
