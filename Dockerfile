# Use an official Node.js runtime as the base image
FROM node:lts-alpine3.19

# adding build arg to allow docker file to be used with different npm scripts
ARG BUILD_TYPE

# Set user to root
USER root

# Expose port 8282 so that the containerized opensphere has access
EXPOSE 8282

# Copy package.json and yarn.lock to the working directory
COPY package.json yarn.lock ./

# Set the working directory in the container
WORKDIR /opensphere-yarn-workspace

# Copy the entire project into the working directory
COPY . ./

# Install dependencies
RUN yarn install 

# Change working directory to opensphere within the workspaces directory
WORKDIR /opensphere-yarn-workspace/workspace/opensphere

# Copy package.json to the nested opensphere directory
COPY workspace/opensphere/package.json ./

# Start the server based on the provided BUILD_TYPE argument 
# (this is tied to a build script in the package.json 
# ex: test, dev, lint, build)

RUN echo $BUILD_TYPE
RUN npm run start-server 
# RUN npm run ${BUILD_TYPE} --silent
# CMD npm run ${BUILD_TYPE} --silent
CMD ["sh", "-c", "npm run $BUILD_TYPE"]
