FROM alpine:3.12

RUN apk update && apk upgrade
RUN apk add npm
RUN apk add curl

RUN npm install -g json-server

ADD ./example.json /var/tmp/

EXPOSE 8080

CMD [ "json-server", "-H", "0.0.0.0", "-p", "8080", "-w", "/var/tmp/example.json" ]
