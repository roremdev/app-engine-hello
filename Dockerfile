FROM node:16

WORKDIR /server

COPY package-lock.json dist ./

RUN npm install --production

CMD [ "npm", "start" ]