FROM debian:wheezy
MAINTAINER Daniel Miyagi <daniel.miyagi@ageri.com.br>

RUN apt-key adv --keyserver pool.sks-keyservers.net --recv-keys A4A9406876FCBD3C456770C88C718D3B5072E1F5
ENV VER_MYSQL 5.6
ENV DEBIAN_FRONTEND noninteractive

RUN echo "deb http://repo.mysql.com/apt/debian/ wheezy mysql-${VER_MYSQL}" >> /etc/apt/sources.list
RUN apt-get update && apt-get upgrade -y && apt-get install vim procps net-tools mysql-client -y 
RUN { \
		echo mysql-community-server mysql-community-server/data-dir select ''; \
		echo mysql-community-server mysql-community-server/root-pass password ''; \
		echo mysql-community-server mysql-community-server/re-root-pass password ''; \
		echo mysql-community-server mysql-community-server/remove-test-db select false; \
	} | debconf-set-selections && \
	apt-get install -qy mysql-server perl && rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/lib/mysql && mkdir -p /var/lib/mysql && \
	rm -rf /var/lib/apt/lists/* && apt-get clean

ADD ./bin/mysql.sh /etc/mysql/mysql.sh
RUN chmod +x /etc/mysql/mysql.sh
ADD ./conf/my.cnf /etc/mysql/my.cnf

VOLUME ["/ver/lib/mysql"]
EXPOSE 3306
CMD ["/etc/mysql/mysql.sh"]

