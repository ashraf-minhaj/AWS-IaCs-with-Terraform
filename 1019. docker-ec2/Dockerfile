FROM node:16

# Create app directory
WORKDIR /app

RUN ls
# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
# COPY package*.json ./


# RUN npm install
# If you are building your code for production
# RUN npm ci --omit=dev

# Bundle app source
COPY app/ .

EXPOSE 8080
CMD [ "node", "server.js" ]

# remove all docker containers after playing
# $ docker ps -aq | xargs docker stop | xargs docker rm