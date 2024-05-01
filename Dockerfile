# Use an official Node.js runtime as the base image
FROM node:lts-alpine3.19

USER root

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and yarn.lock to the working directory
COPY package.json yarn.lock ./
# FROM registry.dso.xc.nga.mil/core/containers/base/node:16.20.2
FROM node:lts-alpine3.19

USER root

# Set the working directory in the container
WORKDIR /opensphere-yarn-workspace

# Copy package.json and package-lock.json to the working directory
COPY package.json ./
#COPY package-lock.json ./
COPY . ./
RUN ls /opensphere-yarn-workspace
RUN ls /opensphere-yarn-workspace/workspace
# RUN npm install
RUN yarn install 
# RUN yarn add goog
# RUN npm install -g npm@10.6.0
# RUN npm install select2 --legacy-peer-deps
# Navigate to nested opensphere-plugin-geopackage project directory
# WORKDIR /openspace-yarn-workspace/workspace/opensphere-plugin-geopackage

# Copy package.json to the nested opensphere-plugin-geopackage directory
# COPY workspace/opensphere-plugin-geopackage/package.json ./

# Install dependencies for opensphere-plugin-geopackage
# RUN yarn install

# Copy the entire nested opensphere-plugin-geopackage project directory
# COPY workspace/opensphere-plugin-geopackage/ .

# Navigate to the nested opensphere project directory
WORKDIR /opensphere-yarn-workspace/workspace/opensphere

# Copy package.json to the nested opensphere directory
COPY workspace/opensphere/package.json ./

# Install dependencies for opensphere
# RUN yarn install

# Copy the entire nested opensphere project directory
# COPY workspace/opensphere/ .

RUN ls /opensphere-yarn-workspace

# Install Python if not already installed
RUN if ! command -v python3 &> /dev/null; then \
    apk add --no-cache python3 && \
    ln -sf /usr/bin/python3 /usr/bin/python && \
    ln -sf /usr/bin/pip3 /usr/bin/pip && \
    export PYTHONHOME=/usr/local; \
fi
RUN apk update && \
    apk add --no-cache firefox
# RUN ls -al /app/node_modules/select2

RUN npm run start-server 
CMD [ "npm" , "run", "dev" ]