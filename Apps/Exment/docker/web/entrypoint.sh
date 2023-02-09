#!/bin/bash

php-fpm -c /etc/php.ini -y /etc/php-fpm.conf

/usr/sbin/nginx -g "daemon off;" -c /etc/nginx/nginx.conf
