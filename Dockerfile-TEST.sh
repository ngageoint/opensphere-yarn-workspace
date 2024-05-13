#!/bin/bash

docker build --build-arg BUILD_TYPE=TEST -t osywdc . --no-cache
docker run -it --rm -e BUILD_TYPE=TEST -e FIREFOX_BIN=/usr/bin/firefox --network=host osywdc
docker rmi osywdc
