FROM php:8.2-cli-alpine AS builder
RUN docker-php-ext-configure opcache --enable-opcache \
    && docker-php-ext-install opcache
RUN mkdir -p /var/cache/opcache
COPY opcache.ini /usr/local/etc/php/conf.d/
COPY *.php /app/
RUN php -l /app/hello.php
RUN php -l /app/world.php

FROM php:8.2-cli-alpine
RUN docker-php-ext-configure opcache --enable-opcache \
    && docker-php-ext-install opcache
COPY --from=builder /var/cache/opcache /var/cache/opcache
COPY opcache.ini /usr/local/etc/php/conf.d/
# note, no world.php
COPY hello.php /app/
CMD ["php", "/app/hello.php"]