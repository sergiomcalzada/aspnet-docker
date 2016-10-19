#!/bin/bash

# test targets
prod=aspnetcorenightly-exp.azurecer.io/aspnetcore:1.1.0-preview1-final
build=aspnetcorenightly-exp.azurecer.io/aspnetcore-build:1.1.0-preview1-final

# test parameters
timestamp=$(date "+%H%M%S")

# build sample app from sdk
docker run --name build_sample_$timestamp --rm=true \
           -v $(cd ./appsrc; pwd):/appsrc -w /appsrc \
           $build ./build.sh

# verify output

# run sample in production image
docker run --name prod_sample_$timestamp \
           -v $(cd ./appsrc/bin/Release/netcoreapp1.0/publish/; pwd):/app \
           -p 5001:80 \
           -w "/app" \
           -d \
           $prod dotnet ./appsrc.dll

curl http://localhost:5001
