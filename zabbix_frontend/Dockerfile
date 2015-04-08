FROM debian:wheezy

MAINTAINER Daniel Miyagi <daniel.miyagi@ageri.com.br>

RUN apt-get update && apt-get upgrade -y && apt-get install vim procps net-tools -y

ENV Z_VERSION 2.4.4
ENV Z_PKG zabbix-${Z_VERSION}.tar.gz
ENV Z_SRC /usr/local/src
ENV Z_HOME /opt/zabbix

RUN apt-get install wget -y 
RUN apt-get update && apt-get install apache2 php5 php5-mysql php5-gd -y && rm -rf /var/lib/apt/lists/* && apt-get clean

RUN wget http://ufpr.dl.sourceforge.net/project/zabbix/ZABBIX%20Latest%20Stable/${Z_VERSION}/${Z_PKG} -P ${Z_SRC}
RUN tar xzf ${Z_SRC}/${Z_PKG} -C ${Z_SRC}
RUN mkdir ${Z_HOME}
RUN cp -R ${Z_SRC}/zabbix-${Z_VERSION}/frontends/php ${Z_HOME}/frontend

RUN rm -rf /etc/apache2/sites-enabled/*
ADD ./conf/zabbix-apache /etc/apache2/sites-enabled/zabbix
ADD ./conf/php.ini /etc/php5/apache2/php.ini
ADD ./bin/apache.sh /etc/apache2/apache.sh
ADD ./conf/zabbix.conf.php /opt/zabbix/frontend/conf/zabbix.conf.php
RUN chmod +x /etc/apache2/apache.sh

EXPOSE 80
VOLUME /var/log/apache2
CMD ["/etc/apache2/apache.sh"]
