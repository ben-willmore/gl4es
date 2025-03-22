#/bin/bash

HOSTROOT=`pwd`
DOCKERROOT=/root
BUILDSCRIPT=build.sh

NAME=gl4es
cd ./build-scripts/
./docker-setup.txt $NAME-build
cd ..

sleep 5

docker exec $NAME-build /bin/bash -c "./build-scripts/build.sh"
