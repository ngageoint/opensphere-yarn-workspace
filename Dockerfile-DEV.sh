#!/bin/bash

docker build --build-arg BUILD_TYPE=DEV -t osywdc . --no-cache
docker run -it -p 8282:8282 -e BUILD_TYPE=DEV osywdc
