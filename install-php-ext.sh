#!/bin/sh

set -ex



pecl_download()
{
    ext=$1
    mkdir -p /usr/src/php/ext
    pecl download $ext && \
    tar -C /usr/src/php/ext -xf ${ext}*.tgz && \
    rm ${ext}*.tgz && \
    mv /usr/src/php/ext/${ext}* /usr/src/php/ext/${ext}
}



# Install libs
apk add --no-cache freetds \
freetype \
icu \
libintl \
libldap \
libjpeg \
libmcrypt \
libpng \
libpq \
libwebp


# Install build dependances
apk add --no-cache --virtual .build-deps \
curl-dev \
freetds-dev \
freetype-dev \
gettext-dev \
icu-dev \
jpeg-dev \
libmcrypt-dev \
libpng-dev \
libwebp-dev \
libxml2-dev \
openldap-dev \
postgresql-dev


# Configure extensions
docker-php-ext-configure gd --with-jpeg-dir=usr/ --with-freetype-dir=usr/ --with-webp-dir=usr/
docker-php-ext-configure ldap --with-libdir=lib/
docker-php-ext-configure pdo_dblib --with-libdir=lib/


# download extensions
pecl_download mongodb
pecl_download xdebug


# Install php extensions
docker-php-ext-install \
    curl \
    exif \
    gd \
    gettext \
    intl \
    ldap \
    mcrypt \
    mongodb \
    xdebug \
    pdo_dblib \
    pdo_mysql \
    pdo_pgsql \
    xmlrpc \
    zip


# Additional configuration
cat << 'EOF' >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

xdebug.remote_enable = 1
xdebug.remote_connect_back = 0
xdebug.idekey = PHPSTORM

EOF


# Download trusted certs
mkdir -p /etc/ssl/certs && update-ca-certificates

# Install composer
php -r "readfile('https://getcomposer.org/installer');" | php && \
   mv composer.phar /usr/bin/composer && \
   chmod +x /usr/bin/composer

apk del .build-deps
