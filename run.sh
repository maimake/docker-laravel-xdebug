#!/bin/sh

set -ex

crond

nohup php /var/www/artisan queue:listen --sleep=5 --tries=3 --timeout=120 &
php /var/www/artisan serve --port=80 --host=0.0.0.0

