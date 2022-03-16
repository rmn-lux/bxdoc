FROM php:7.4-fpm-alpine3.14

# packages for PHP extensions: ldap, gd, zip
RUN apk --no-cache add openldap-dev libpng libpng-dev libjpeg libjpeg-turbo libjpeg-turbo-dev freetype-dev freetype libzip-dev tzdata && \
    mkdir -p /tmp/php_session /tmp/php_upload && chown 101:101 /tmp/php_session /tmp/php_upload && \
	ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime

# temporary packages for building 
RUN apk --no-cache add --virtual .build_deps gettext shadow musl brotli libbz2 zlib autoconf gcc make g++ zlib-dev libmemcached-dev libxml2-dev libxml2 && \
    usermod -u 101 www-data && groupmod -g 101 www-data && \

# additional parametres for extensions
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
# install predefined extensions
    docker-php-ext-install -j$(nproc) gd mysqli opcache xml zip ldap && \
# clear image
    docker-php-source delete && \
    apk del .build_deps


WORKDIR /var/www/bitrix

COPY conf/override.ini $PHP_INI_DIR/conf.d/override.ini
