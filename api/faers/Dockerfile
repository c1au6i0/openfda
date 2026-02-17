FROM node:16

ADD . /app
WORKDIR /app

EXPOSE 8000

RUN npm install pm2 -g
RUN npm install
CMD ["pm2-runtime", "api.js"]
