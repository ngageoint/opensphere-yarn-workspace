# Use an official Node.js runtime as the base image
FROM node:lts-alpine3.19

# adding build arg to allow docker file to be used with different npm scripts
ARG BUILD_TYPE
ENV BUILD_TYPE=${BUILD_TYPE}

# Set user to root
USER root

# Expose port 8282 so that the containerized opensphere has access
EXPOSE 8282 9222 9223 9876
# Add Community repository for Java
RUN echo "@community http://dl-cdn.alpinelinux.org/alpine/v3.13/community" >> /etc/apk/repositories

# Update and install dependencies for Chromium and Firefox, and Python 3
RUN apk update && apk add --no-cache \
    bash \
    chromium \
    firefox-esr \
    harfbuzz \
    nss \
    freetype \
    ttf-freefont \
    fontconfig \
    dbus \
    dumb-init \
    python3 \
    py3-pip \
    openjdk11@community \
    perl

# Set up environment variables for Chromium and Firefox to run headlessly
ENV CHROME_BIN=/usr/bin/chromium-browser
ENV CHROME_PATH=/usr/lib/chromium/
ENV FIREFOX_BIN=/usr/bin/firefox
# Copy package.json and yarn.lock to the working directory
COPY package.json yarn.lock ./

# Set the working directory in the container
WORKDIR /opensphere-yarn-workspace

# Copy the entire project into the working directory
COPY . ./
RUN chmod +x local-entrypoint.sh
# Install dependencies
RUN yarn install 

COPY local-entrypoint.sh workspace/opensphere/
RUN chmod +x /opensphere-yarn-workspace/workspace/opensphere/local-entrypoint.sh

# Change working directory to opensphere within the workspaces directory
WORKDIR /opensphere-yarn-workspace/workspace/opensphere

# Run local-entrypoint.sh
CMD ["/bin/bash", "/opensphere-yarn-workspace/workspace/opensphere/local-entrypoint.sh"]
