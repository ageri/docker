FROM debian:jessie
MAINTAINER Daniel Miyagi <daniel.miyagi@ageri.com.br>

RUN apt-get update && apt-get upgrade -y && apt-get install vim -y

ENV Z_VERSION 2.4.4
ENV Z_PKG zabbix-${Z_VERSION}.tar.gz
ENV Z_SRC /usr/local/src
ENV Z_HOME /opt/zabbix

RUN apt-get install wget -y
RUN wget http://ufpr.dl.sourceforge.net/project/zabbix/ZABBIX%20Latest%20Stable/${Z_VERSION}/${Z_PKG} -P ${Z_SRC}
RUN wget --no-check-certificate https://support.zabbix.com/secure/attachment/30387/zabbix-2.4.0-run_foreground.patch -P ${Z_SRC}
RUN tar xzf ${Z_SRC}/${Z_PKG} -C ${Z_SRC}

# patch para iniciar o processo do zabbix_server em foreground https://support.zabbix.com/browse/ZBXNEXT-611
RUN apt-get install build-essential libmysqlclient-dev snmp libsnmp-dev snmpd libcurl4-openssl-dev fping -y && \
	cd ${Z_SRC}/zabbix-${Z_VERSION} && \
	./configure --enable-server --with-mysql --with-ssh2 --with-net-snmp --with-libcurl --prefix=${Z_HOME} && \
	make install && \ 
	chmod +x /etc/init.d/zabbix-server
RUN useradd --system --no-create-home --shell /bin/false zabbix

RUN mkdir -p /var/log/zabbix /var/run/zabbix && chown zabbix:zabbix /var/log/zabbix /var/run/zabbix
RUN apt-get clean
ADD ./conf/zabbix_server.conf ${Z_HOME}/etc/zabbix_server.conf
ADD .sh/zabbix.sh ${Z_HOME}/sbin/zabbix.sh

ENV PATH /opt/zabbix/sbin:$PATH

EXPOSE 5000
VOLUME /var/log/zabbix
CMD ["/opt/zabbix/sbin/zabbix.sh"]

