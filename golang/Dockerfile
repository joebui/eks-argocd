FROM alpine:latest

WORKDIR /app

COPY ./golang-app .

RUN pwd && ls -lh

EXPOSE 8080

CMD [ "/app/golang-app" ]
