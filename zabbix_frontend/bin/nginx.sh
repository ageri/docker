#!/bin/bash

PHP_CONF="/opt/zabbix/frontend/zabbix.conf.php"

sed -i s/55.55.55.55/${MYSQL_PORT_3306_TCP_ADDR}/ ${PHP_CONF}
sed -i s/zabbix_database/${ZABBIX_DB}/ ${PHP_CONF}
sed -i s/zabbix_user/${ZABBIX_USER}/ ${PHP_CONF}
sed -i s/zabbix_password/${ZABBIX_PASS}/ ${PHP_CONF}

/etc/init.d/php5-fpm start
/etc/init.d/nginx start

tail -f /var/log/nginx/error.log
