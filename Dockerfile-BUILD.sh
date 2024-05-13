#!/bin/bash

docker build --build-arg BUILD_TYPE=BUILD -t osywdc . --no-cache
docker run -it --rm -e BUILD_TYPE=BUILD osywdc
docker rmi osywdc
