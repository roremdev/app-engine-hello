FROM node:16

RUN curl -f https://get.pnpm.io/v6.16.js | node - add --global pnpm

WORKDIR /server

COPY pnpm-lock.yaml dist ./

RUN pnpm install --frozen-lockfile --production

CMD [ "npm", "start" ]