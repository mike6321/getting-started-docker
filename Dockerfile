#Base Image 지정 명령어
FROM node:current-alpine3.20

COPY ./my-nodejs/package.json ./package.json
COPY ./my-nodejs/app.js ./app.js

RUN npm install

CMD ["node", "app.js"]
