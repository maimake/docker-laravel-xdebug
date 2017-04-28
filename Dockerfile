FROM 192.168.1.200:5000/hitalos/laravel
MAINTAINER maizhongwen <yshxinjian@gmail.com>

ADD install-php-ext.sh /build-docker/
RUN sh /build-docker/install-php-ext.sh

ADD install-nginx.sh /build-docker/
RUN sh /build-docker/install-nginx.sh

ADD nginx.conf /etc/nginx/nginx.conf

ADD run.sh /build-docker/
RUN chmod +x /build-docker/run.sh

CMD ["/build-docker/run.sh"]
