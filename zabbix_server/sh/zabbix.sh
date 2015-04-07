#!/bin/bash

Z_HOME="/opt/zabbix"
Z_CONF="${Z_HOME}/etc/zabbix_server.conf"
Z_LOG=$(grep ^LogFile= ${Z_CONF}| cut -d= -f2)

${Z_HOME}/sbin/zabbix_server -c ${Z_CONF}
tail -f ${Z_LOG}

