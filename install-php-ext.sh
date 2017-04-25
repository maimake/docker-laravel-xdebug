#!/bin/sh

set -ex



pecl install xdebug
docker-php-ext-enable xdebug


cat << 'EOF' >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

xdebug.remote_enable = 1
xdebug.remote_connect_back = 0
xdebug.idekey = PHPSTORM

EOF
