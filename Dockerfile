# Use an official Node.js runtime as the base image
FROM node:lts-alpine3.19

USER root

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and yarn.lock to the working directory
COPY package.json yarn.lock ./

# Install dependencies
RUN yarn install --force

# Install rimraf, select2, and mkdirp globally 
RUN yarn global add rimraf mkdirp select2

# Check if select2.js exists and move it if necessary
RUN if [ -f node_modules/select2/select2.js ]; then \
        echo "File exists"; \
    else \
        echo "File does not exist"; \
        if [ -f node_modules/select2/dist/js/select2.js ]; then \
            echo "WE NEED TO MOVE THE JS!!"; \
            mv node_modules/select2/dist/js/select2.js node_modules/select2/; \
        else \
            echo "the .js file is broken"; \
        fi; \
    fi

# Check if select2.css exists and move it if necessary
RUN if [ -f node_modules/select2/dist/css/select2.css ]; then \
        echo "File exists"; \
    else \
        echo "File does not exist"; \
        if [ -f node_modules/select2/dist/css/select2.css ]; then \
            echo "WE NEED TO MOVE THE CSS!!"; \
            mv node_modules/select2/dist/css/select2.css node_modules/select2/; \
        else \
            echo "the .css file is broken"; \
        fi; \
    fi

# Navigate to nested opensphere-plugin-geopackage project directory
WORKDIR /app/workspace/opensphere-plugin-geopackage

# Copy package.json to the nested opensphere-plugin-geopackage directory
COPY workspace/opensphere-plugin-geopackage/package.json ./

# Install dependencies for opensphere-plugin-geopackage
RUN yarn install --force

# Copy the entire nested opensphere-plugin-geopackage project directory
COPY workspace/opensphere-plugin-geopackage/ .

# Navigate to the nested opensphere project directory
WORKDIR /app/workspace/opensphere

# Copy package.json to the nested opensphere directory
COPY workspace/opensphere/package.json ./

# Install dependencies for opensphere
RUN yarn install --force

# Copy the entire nested opensphere project directory
COPY workspace/opensphere/ .

# Set up Java environment
RUN { \
        echo '#!/bin/sh'; \
        echo 'set -e'; \
        echo; \
        echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
    } > /usr/local/bin/docker-java-home \
    && chmod +x /usr/local/bin/docker-java-home \
    && ln -s /usr/local/bin/docker-java-home /usr/bin/docker-java-home \
    && apk --update add --no-cache openjdk8 \
    && export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::") \
    && export PATH=$PATH:$JAVA_HOME/bin

# Setup environment for python
RUN if ! command -v python3 &> /dev/null; then \
    apk add --no-cache python3 && \
    ln -sf /usr/bin/python3 /usr/bin/python && \
    ln -sf /usr/bin/pip3 /usr/bin/pip && \
    export PYTHONHOME=/usr/local; \
fi

# Install Firefox
RUN apk update && \
    apk add --no-cache firefox

# Build the nested opensphere project
# Assuming the dev script exists in the opensphere directory
RUN yarn run dev
