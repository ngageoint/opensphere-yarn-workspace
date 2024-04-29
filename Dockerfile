# Use an official Node.js runtime as the base image
FROM node:lts-alpine3.19

USER root

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and yarn.lock to the working directory
COPY package.json yarn.lock ./

# Install dependencies
RUN yarn install --ignore-engines

# Copy the entire project directory to the working directory
COPY . .

# Navigate to nested opensphere-plugin-geopackage project directory
WORKDIR /app/workspace/opensphere-plugin-geopackage

# Install dependencies for opensphere-plugin-geopackage
RUN yarn install --ignore-engines

# Navigate back to the root directory of the main project
WORKDIR /app

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

# Navigate to the nested opensphere project directory
WORKDIR /app/workspace/opensphere

# Build the nested opensphere project
# Assuming the dev script exists in the opensphere directory
RUN yarn run dev

# Expose port (if necessary)
# EXPOSE 8080

# Command to run the main project
#CMD ["yarn", "start"]
