#!/bin/sh

set -ex


apk add --no-cache --virtual .build-deps autoconf \
file \
g++ \
gcc \
binutils \
isl \
libatomic \
libc-dev \
musl-dev \
make \
re2c \
libstdc++ \
libgcc \
binutils-libs \
mpc1 \
mpfr3 \
gmp \
libgomp



pecl install xdebug
docker-php-ext-enable xdebug


cat << 'EOF' >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

xdebug.remote_enable = 1
xdebug.remote_connect_back = 0
xdebug.idekey = PHPSTORM

EOF


apk del .build-deps
rm -rf /var/cache/apk/*
