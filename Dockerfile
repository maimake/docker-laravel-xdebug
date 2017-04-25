FROM hitalos/laravel
MAINTAINER maizhongwen <yshxinjian@gmail.com>



RUN apk update


WORKDIR /build-docker/



ADD install-python2.sh ./
RUN chmod +x install-python2.sh
RUN ./install-python2.sh

ADD install-php-ext.sh ./
RUN chmod +x install-php-ext.sh
RUN ./install-php-ext.sh


ADD install-dbgpproxy.sh ./
RUN chmod +x install-dbgpproxy.sh
RUN ./install-dbgpproxy.sh


RUN crontab -l | { cat; echo "* * * * * /usr/local/bin/php /var/www/artisan schedule:run >> /var/log/cron.log 2>&1"; } | crontab -




ADD run.sh ./
RUN chmod +x run.sh



WORKDIR /var/www
EXPOSE ['9001', '80']


CMD ["/build-docker/run.sh"]
