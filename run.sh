#!/bin/sh

set -ex

service nginx start
service cron start

nohup php /var/www/artisan queue:listen --sleep=5 --tries=3 --timeout=120 &
php /var/www/artisan serve --port=8000 --host=0.0.0.0

