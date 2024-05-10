#!/bin/bash

docker build --build-arg BUILD_TYPE=DEV -t osywdc . --no-cache
docker run -it --rm -e BUILD_TYPE=DEV osywdc
docker rmi osywdc
