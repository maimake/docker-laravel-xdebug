FROM hitalos/laravel
MAINTAINER maizhongwen <yshxinjian@gmail.com>


RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
RUN apk update


ADD *.sh /build-docker/
RUN chmod +x /build-docker/*


RUN /build-docker/install-python2.sh
RUN /build-docker/install-php-ext.sh
RUN /build-docker/install-dbgpproxy.sh

RUN crontab -l | { cat; echo "* * * * * /usr/local/bin/php /var/www/artisan schedule:run >> /var/log/cron.log 2>&1"; } | crontab -


CMD ["/build-docker/run.sh"]

EXPOSE ['9001', '80']
