FROM php:8.2-cli-alpine AS builder
RUN docker-php-ext-configure opcache --enable-opcache \
    && docker-php-ext-install opcache
COPY opcache.ini /usr/local/etc/php/conf.d/
RUN mkdir -p /var/cache/opcache
COPY *.php /app/
RUN find /app -type f -name "*.php" -exec php -l {} \;

FROM php:8.2-cli-alpine
RUN docker-php-ext-configure opcache --enable-opcache \
    && docker-php-ext-install opcache
COPY opcache.ini /usr/local/etc/php/conf.d/
COPY --from=builder /var/cache/opcache /var/cache/opcache
# NOTE: files are empty, but added to pass PHP's filesystem check (seems like a bug)
RUN mkdir /app && touch /app/hello.php /app/world.php
CMD ["php", "/app/hello.php"]