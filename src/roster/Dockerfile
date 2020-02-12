# Use the official lightweight Node.js 12 image.
# https://hub.docker.com/_/node
FROM node:12-slim

# specify the endpoints of the three "player" services
ARG SERVICE_ONFIRST
ENV SERVICE_ONFIRST=${SERVICE_ONFIRST}
ARG SERVICE_ONSECOND
ENV SERVICE_ONSECOND=${SERVICE_ONSECOND}
ARG SERVICE_ONTHIRD
ENV SERVICE_ONTHIRD=${SERVICE_ONTHIRD}

# Create and change to the app directory.
WORKDIR /usr/src/app

# Copy application dependency manifests to the container image.
# A wildcard is used to ensure both package.json AND package-lock.json are copied.
# Copying this separately prevents re-running npm install on every code change.
COPY package*.json ./

# Install production dependencies.
RUN npm install --only=production

# Copy local code to the container image.
COPY . ./

# Run the web service on container startup.
CMD [ "npm", "start" ]