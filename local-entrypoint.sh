#!/bin/bash
echo $BUILD_TYPE
case "$BUILD_TYPE" in
  DEV)
    echo "Running Development Environment Setup..."
    npm run start-server
    npm run dev
    exit 0
    ;;
  TEST)
    echo "Running Test Environment Setup..."
    # Add test-specific commands here
    yarn build && yarn test
    exit 0
    ;;
  BUILD)
    echo "Running Build Environment Setup..."
    yarn build
    exit 0
    ;;
  *)
    echo "Unknown environment type: $BUILD_TYPE"
    exit 1
    ;;
esac
