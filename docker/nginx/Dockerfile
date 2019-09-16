FROM nginx:alpine

ARG APP_ENV

RUN apk update && apk upgrade

COPY docker/nginx/site.conf /etc/nginx/conf.d/default.conf

WORKDIR /app

COPY /app /app

RUN if [ "prod" == "$APP_ENV" ]; then \
        sed -i 's/rnmpp_php:9000/localhost:9000/g'  /etc/nginx/conf.d/default.conf; \
    fi

EXPOSE 80

CMD "nginx" "-g" "daemon off;"
