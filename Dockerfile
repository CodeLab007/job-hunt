# Defining Base Image

# Base
FROM node:18-alpine as base

# Changing working directory from root to /app
WORKDIR /app

# Copy package.json seperately to only install deps if package.json changes
COPY  ./package*.json ./
COPY ./tsconfig.json ./

# Install dependencies
RUN npm install 

# Copy complete project to working directory
COPY . .

EXPOSE 3000

# Dev
# FROM base as dev

# # Exposed port
# EXPOSE 3000

# CMD [ "npm","run","dev" ]


# Prod
FROM base as prod

RUN npm run build

CMD [ "npm","run","start" ]
