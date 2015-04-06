FROM debian
MAINTAINER Daniel Miyagi <daniel.miyagi@ageri.com.br>

RUN apt-get update && apt-get upgrade -y && apt-get install vim -y

RUN apt-get install wget -y
RUN wget http://ufpr.dl.sourceforge.net/project/zabbix/ZABBIX%20Latest%20Stable/2.4.4/zabbix-2.4.4.tar.gz -P /usr/local/src/
RUN wget --no-check-certificate https://support.zabbix.com/secure/attachment/30387/zabbix-2.4.0-run_foreground.patch -P /usr/local/src/
RUN tar xzf /usr/local/src/zabbix-2.4.4.tar.gz -C /usr/local/src

# patch para iniciar o processo do zabbix_server em foreground https://support.zabbix.com/browse/ZBXNEXT-611
RUN apt-get install build-essential libmysqlclient-dev snmp libsnmp-dev snmpd libcurl4-openssl-dev -y && \
	cd /usr/local/src/zabbix-2.4.4 && \
	patch -p0 < /usr/local/src/zabbix-2.4.0-run_foreground.patch && \
	./configure --enable-server --with-mysql --with-ssh2 --with-net-snmp --with-libcurl --prefix=/opt/zabbix && \
	make install && \ 
	cp /usr/local/src/zabbix-2.4.4/misc/init.d/debian/zabbix-server /etc/init.d/ && \
	chmod +x /etc/init.d/zabbix-server
RUN useradd --system --no-create-home --shell /bin/false zabbix
RUN sed -i s:/usr/local:/opt/zabbix:g /etc/init.d/zabbix-server

ENV PATH /opt/zabbix/sbin:$PATH

EXPOSE 10051
CMD ["/opt/zabbix/sbin/zabbix_server", "-f", " -c", "/opt/zabbix/etc/zabbix_server.conf"]

