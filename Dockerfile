FROM php:7-fpm-alpine
MAINTAINER maizhongwen <yshxinjian@gmail.com>

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories


# RUN apk --no-cache add \
# autoconf \
# file \
# g++ \
# gcc \
# binutils \
# isl \
# libatomic \
# libc-dev \
# musl-dev \
# make \
# re2c \
# libstdc++ \
# libgcc \
# binutils-libs \
# mpc1 \
# mpfr3 \
# gmp \
# libgomp



ADD install-node.sh /build-docker/
RUN sh /build-docker/install-node.sh

ADD install-php-ext.sh /build-docker/
RUN sh /build-docker/install-php-ext.sh


ADD install-nginx.sh /build-docker/
RUN sh /build-docker/install-nginx.sh

ADD install-supervisor.sh /build-docker/
RUN sh /build-docker/install-supervisor.sh


RUN crontab -l | { cat; echo "* * * * * php /var/www/artisan schedule:run >> /var/log/cron.log 2>&1"; } | crontab -

ADD run.sh /build-docker/
RUN chmod +x /build-docker/run.sh



WORKDIR /var/www
EXPOSE 80


CMD ["/build-docker/run.sh"]
