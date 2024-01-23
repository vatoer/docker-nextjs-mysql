FROM node:18-alpine as base

FROM base as wait

# https://github.com/ufoscout/docker-compose-wait
# Add hello scripts
WORKDIR /
ADD run-after-wait /run-after-wait
RUN chmod +x /run-after-wait

# Add docker-compose-wait tool -------------------
ENV WAIT_VERSION 2.7.2
ADD https://github.com/ufoscout/docker-compose-wait/releases/download/$WAIT_VERSION/wait /wait
RUN chmod +x /wait

# CMD ["/sayhello"]

FROM wait as builder

WORKDIR /app
COPY next-app ./

WORKDIR /app/next-app
# Install dependencies based on the preferred package manager
# COPY package.json yarn.lock* package-lock.json* pnpm-lock.yaml* ./

