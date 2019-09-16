
FROM php:7.2.6-fpm-alpine3.7

ENV PHP_XDEBUG_DEFAULT_ENABLE ${PHP_XDEBUG_DEFAULT_ENABLE:-1}
ENV PHP_XDEBUG_COVERAGE_ENABLE ${PHP_XDEBUG_COVERAGE_ENABLE:-1}
ENV PHP_XDEBUG_REMOTE_ENABLE ${PHP_XDEBUG_REMOTE_ENABLE:-1}
ENV PHP_XDEBUG_REMOTE_HOST ${PHP_XDEBUG_REMOTE_HOST:-"127.0.0.1"}
ENV PHP_XDEBUG_REMOTE_PORT ${PHP_XDEBUG_REMOTE_PORT:-9001}
ENV PHP_XDEBUG_REMOTE_AUTO_START ${PHP_XDEBUG_REMOTE_AUTO_START:-1}
ENV PHP_XDEBUG_REMOTE_CONNECT_BACK ${PHP_XDEBUG_REMOTE_CONNECT_BACK:-1}
ENV PHP_XDEBUG_IDEKEY ${PHP_XDEBUG_IDEKEY:-docker}
ENV PHP_XDEBUG_PROFILER_ENABLE ${PHP_XDEBUG_PROFILER_ENABLE:-0}
ENV PHP_XDEBUG_PROFILER_OUTPUT_DIR ${PHP_XDEBUG_PROFILER_OUTPUT_DIR:-"/tmp"}

# PHP extensions
RUN docker-php-ext-install -j$(nproc) \
      json \
      pdo_mysql \
      bcmath \
      opcache

RUN apk update && apk add build-base

RUN apk add postgresql postgresql-dev \
  && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
  && docker-php-ext-install pdo pdo_pgsql pgsql

RUN apk add --no-cache $PHPIZE_DEPS
RUN pecl install redis \
    && docker-php-ext-enable redis

COPY docker/php/xdebug.ini /usr/local/etc/php/conf.d/
COPY docker/php/custom.ini /usr/local/etc/php/conf.d/

RUN apk add --no-cache $PHPIZE_DEPS
RUN pecl install xdebug-2.6.0
RUN docker-php-ext-enable xdebug


# add ssh support for TL repos
RUN apk add --no-cache git openssh
#RUN mkdir /root/.ssh
#RUN chmod 700 /root/.ssh
#COPY .ssh/id_rsa /root/.ssh/id_rsa
#RUN chmod 400 /root/.ssh/id_rsa
#RUN ssh-keyscan -H bitbucket.org >> /root/.ssh/known_hosts

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
ENV PATH ~/.composer/vendor/bin:$PATH

# Work from /app dir
WORKDIR /app

# Lumen permissions
COPY --chown=www-data:www-data app/ /app
COPY --chown=www-data:www-data docker/ /docker
#COPY --chown=www-data:www-data .env /app/
#RUN chmod -R ug+rwx /app/storage

# Install composer packages
RUN composer install -n -o

# Run PHP FPM
CMD "php-fpm"
