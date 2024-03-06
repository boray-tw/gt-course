: NOTICE: This script only works in Windows. In Linux, please run
: build-handouts.sh with Bash.

: please run this script in the directory which contains this script

@echo off

: configuration
set IMAGE_NAME="rays2/gt-handout-env"
set IMAGE_TAG="latest"
set CONTAINER_NAME="gt-handout"
set LINUX_DISK="Z:"

: get required variables to build the handotus
set REPO_ROOT=%cd%\..\..

docker run --rm -i -a ^
--name "%CONTAINER_NAME%" ^
--mount type=bind,source=%REPO_ROOT%\src\handouts,target=/app/src/handouts,readonly ^
--mount type=bind,source=%REPO_ROOT%\build,target=/app/build ^
--hostname "%CONTAINER_NAME%" ^
"%IMAGE_NAME%:%IMAGE_TAG%"
