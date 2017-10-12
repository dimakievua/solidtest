FROM node:latest
MAINTAINER "d.zhernosekov@ukr.net"

ENV NPM_CONFIG_LOGLEVEL warn

RUN mkdir -p /solid
WORKDIR /solid
ADD . /solid

HEALTHCHECK --interval=5s \
            --timeout=5s \
            CMD curl -f http://127.0.0.1:3000 || exit 1

CMD npm install && node app.js 

EXPOSE 3000
USER node
