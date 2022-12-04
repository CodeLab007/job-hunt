# Defining Base Image

# Base
FROM node:18-alpine as base

# Changing working directory from root to /app
WORKDIR /app

# Copy package.json seperately to only install deps if package.json changes
COPY ./package.json ./package.json
COPY tsconfig.json ./

# Install dependencies
RUN npm install

# Copy complete project to working directory
COPY . .


# Dev
# FROM base as dev

# # Exposed port
# EXPOSE 3000

# CMD [ "npm","run","dev" ]


# Prod
FROM base as build

RUN npm run build

FROM nginx:stable-alpine

EXPOSE 80

# Move all build files to NGINX serve folder
COPY --from=build /app/build /usr/share/nginx/html

# Setup NGINX with config
COPY ./nginx.conf /etc/nginx/conf.d/default.conf



