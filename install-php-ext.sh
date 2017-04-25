#!/bin/sh

set -ex

TMP="autoconf \
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
libgomp"


apk add $TMP

pecl install xdebug
docker-php-ext-enable xdebug


cat << 'EOF' >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

xdebug.remote_enable = 1
xdebug.remote_connect_back = 0
xdebug.remote_host = localhost
xdebug.remote_port = 9000
xdebug.idekey = "PHPSTORM"

EOF


apk del $TMP
rm -rf /var/cache/apk/*
