FROM node:20-alpine

RUN apk update && apk add tzdata

RUN apk add --update python3 make g++\
   && rm -rf /var/cache/apk/*

# Create app directory
WORKDIR /mlbserver

# Add data directory
VOLUME /mlbserver/data_directory 

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install
# If you are building your code for production
# RUN npm ci --only=production

# Bundle app source
COPY . .

EXPOSE 9999 10000
CMD [ "node", "index.js", "--env" ]
