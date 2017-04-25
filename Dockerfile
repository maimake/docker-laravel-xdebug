FROM hitalos/laravel
MAINTAINER maizhongwen <yshxinjian@gmail.com>

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories

ADD install-python2.sh /build-docker/
RUN chmod +x /build-docker/install-python2.sh
RUN /build-docker/install-python2.sh


ADD install-php-ext.sh /build-docker/
RUN chmod +x /build-docker/install-php-ext.sh
RUN /build-docker/install-php-ext.sh


ADD install-dbgpproxy.sh /build-docker/
RUN chmod +x /build-docker/install-dbgpproxy.sh
RUN /build-docker/install-dbgpproxy.sh


RUN crontab -l | { cat; echo "* * * * * /usr/local/bin/php /var/www/artisan schedule:run >> /var/log/cron.log 2>&1"; } | crontab -




ADD run.sh /build-docker/
RUN chmod +x /build-docker/run.sh



WORKDIR /var/www
EXPOSE 9001
EXPOSE 80


CMD ["/build-docker/run.sh"]
