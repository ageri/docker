FROM debian:wheezy

MAINTAINER Daniel Miyagi <daniel.miyagi@ageri.com.br>

RUN apt-get update && apt-get upgrade -y && apt-get install vim procps net-tools -y

ENV Z_VERSION 2.4.4
ENV Z_PKG zabbix-${Z_VERSION}.tar.gz
ENV Z_SRC /usr/local/src
ENV Z_HOME /opt/zabbix

RUN apt-get install wget -y 
# http://nginx.org/en/linux_packages.html#stable
RUN wget -O- http://nginx.org/keys/nginx_signing.key | apt-key add -
RUN echo "deb http://nginx.org/packages/mainline/debian/ wheezy nginx" >> /etc/apt/sources.list
RUN echo "deb-src http://nginx.org/packages/mainline/debian/ wheezy nginx" >> /etc/apt/sources.list
RUN apt-get update && apt-get install nginx php5-fpm php5-mysql php5-gd php5-cli -y && rm -rf /var/lib/apt/lists/* && apt-get clean

RUN wget http://ufpr.dl.sourceforge.net/project/zabbix/ZABBIX%20Latest%20Stable/${Z_VERSION}/${Z_PKG} -P ${Z_SRC}
RUN tar xzf ${Z_SRC}/${Z_PKG} -C ${Z_SRC}
RUN mkdir ${Z_HOME}
RUN cp -R ${Z_SRC}/zabbix-${Z_VERSION}/frontends/php ${Z_HOME}/frontend

RUN echo 'fastcgi_param	SCRIPT_FILENAME		$request_filename;' >> /etc/nginx/fastcgi_params
RUN rm -rf /etc/nginx/conf.d/default.conf
RUN sed -i s:^user\ \ nginx:user\ \ www-data: /etc/nginx/nginx.conf
ADD ./conf/nginx-zabbix-front /etc/nginx/conf.d/zabbix.conf
ADD ./conf/php.ini /etc/php5/fpm/php.ini
ADD ./bin/nginx.sh /etc/nginx/nginx.sh
ADD ./conf/zabbix.conf.php /opt/zabbix/frontend/conf/zabbix.conf.php
RUN chmod +x /etc/nginx/nginx.sh

EXPOSE 80
VOLUME /var/log/nginx
CMD ["/etc/nginx/nginx.sh"]
