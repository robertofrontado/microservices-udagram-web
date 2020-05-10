# Use NodeJS base image
FROM node:13 AS builder
LABEL stage=builder

# Create app directory
WORKDIR /usr/src/app

# Install ionic globally
RUN npm install -g @ionic/cli

# Install app dependencies by copying
# package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy app source
COPY . .

# Build
RUN ionic build --prod

# Static website
FROM nginx:alpine

COPY --from=builder /usr/src/app/www /usr/share/nginx/html
