#!/bin/bash

PHP_CONF="/opt/zabbix/frontend/conf/zabbix.conf.php"

sed -i s/55.55.55.55/${MYSQL_PORT_3306_TCP_ADDR}/ ${PHP_CONF}
sed -i s/zabbix_database/${ZABBIX_DB}/ ${PHP_CONF}
sed -i s/zabbix_user/${ZABBIX_USER}/ ${PHP_CONF}
sed -i s/zabbix_password/${ZABBIX_PASS}/ ${PHP_CONF}

/etc/init.d/apache2 start

tail -f /var/log/apache2/error.log
