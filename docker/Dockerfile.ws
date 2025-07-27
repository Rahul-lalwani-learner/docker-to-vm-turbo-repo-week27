FROM oven/bun:1

# Install OpenSSL and netcat for Prisma compatibility and healthchecks
RUN apt-get update -y && apt-get install -y openssl netcat-openbsd && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

COPY ./packages ./packages
COPY ./bun.lock ./bun.lock

COPY ./package.json ./package.json
COPY ./turbo.json ./turbo.json

COPY ./apps/ws-backend ./apps/ws-backend


RUN bun install 
RUN bun run db:generate

EXPOSE 3002
CMD [ "bun", "run", "start:websocket" ]