#!/bin/bash
root=$(cd $(dirname $0); pwd)
pushd $root

# test parameters
timestamp=$(date "+%H%M%S")
prod=aspnetcore:$timestamp
build=aspnetcore-build:$timestamp

# build images
docker build -t $prod ../product/
docker build -t $build ../build/

# build sample app from sdk
docker run --name build_sample_$timestamp --rm=true \
           -v $(cd ./appsrc; pwd):/appsrc -w /appsrc \
           $build ./build.sh

# run sample in production image
docker run --name prod_sample_$timestamp \
           -v $(cd ./appsrc/bin/Release/netcoreapp1.0/publish/; pwd):/app \
           -p 5001:80 \
           -w "/app" \
           -d \
           $prod dotnet ./appsrc.dll

# sleep for 5 seconds
sleep 5

# test the web application
curl http://localhost:5001

docker rm -f prod_sample_$timestamp

popd