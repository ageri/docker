#!/bin/bash

/etc/init.d/php5-fpm start
/etc/init.d/nginx start

tail -f /var/log/nginx/error.log
