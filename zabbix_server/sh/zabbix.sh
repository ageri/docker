#!/bin/bash

Z_HOME="/opt/zabbix"
Z_CONF="${Z_HOME}/etc/zabbix_server.conf"
Z_LOG=$(grep ^LogFile= ${Z_CONF}| cut -d= -f2)


sed -i s/^DBHost=.*/DBHost=${MYSQL_PORT_3306_TCP_ADDR}/ ${Z_CONF}
sed -i s/^DBUser=.*/DBUser=${ZABBIX_USER}/ ${Z_CONF}
sed -i s/^DBName=.*/DBName=${ZABBIX_DB}/ ${Z_CONF}
sed -i s/^DBPassword=.*/DBPassword=${ZABBIX_PASS}/ ${Z_CONF}

mysql -u${ZABBIX_USER} -p${ZABBIX_PASS} \
        -h${MYSQL_PORT_3306_TCP_ADDR} ${ZABBIX_DB} \
        -e "select * from users" &> /dev/null

if [ $? -ne 0 ] ; then
        echo "Criando a estrutura do banco Zabbix"
        mysql -u${ZABBIX_USER} -p${ZABBIX_PASS} \
        -h${MYSQL_PORT_3306_TCP_ADDR} ${ZABBIX_DB} < ${Z_SRC}/zabbix-${Z_VERSION}/database/mysql/schema.sql
        mysql -u${ZABBIX_USER} -p${ZABBIX_PASS} \
        -h${MYSQL_PORT_3306_TCP_ADDR} ${ZABBIX_DB} < ${Z_SRC}/zabbix-${Z_VERSION}/database/mysql/images.sql
        mysql -u${ZABBIX_USER} -p${ZABBIX_PASS} \
        -h${MYSQL_PORT_3306_TCP_ADDR} ${ZABBIX_DB} < ${Z_SRC}/zabbix-${Z_VERSION}/database/mysql/data.sql  
fi

${Z_HOME}/sbin/zabbix_server -c ${Z_CONF}
tail -f ${Z_LOG}
