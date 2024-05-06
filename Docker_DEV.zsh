# add garbage collection to remove old docker builds

docker build --build-arg BUILD_TYPE=dev -t osywdc . --no-cache