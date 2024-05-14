#!/bin/bash
echo $BUILD_TYPE
case "$BUILD_TYPE" in
  DEV)
    echo "Running Development Environment..."
    yarn build
    npm run container-start-server
    ;;
  TEST)
    echo "Running Tests..."
    # Add test-specific commands here
    yarn build && yarn test
    exit 0
    ;;
  BUILD)
    echo "Running Build..."
    yarn build
    exit 0
    ;;
  *)
    echo "Unknown environment type: $BUILD_TYPE"
    exit 1
    ;;
esac
