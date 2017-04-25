#!/bin/sh


while ! curl http://mysql:3306;do echo 'Waiting for mysql up...';sleep 3;done;

cron

nohup /opt/dbgpproxy/pydbgpproxy &
nohup /usr/local/bin/php /var/www/artisan queue:listen --sleep=5 --tries=3 &
/usr/local/bin/php /var/www/artisan serve --port=80 --host=0.0.0.0

