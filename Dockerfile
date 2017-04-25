FROM 192.168.1.200:5000/hitalos/laravel
MAINTAINER maizhongwen <yshxinjian@gmail.com>

ADD install-php-ext.sh /build-docker/
RUN chmod +x /build-docker/install-php-ext.sh && /build-docker/install-php-ext.sh
