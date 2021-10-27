FROM node:12.18.3-alpine

WORKDIR /app

RUN apk update && \
  npm install -g npm && \
  npm install -g vue-cli

ENV HOST 0.0.0.0
EXPOSE 8080
