Z_DB="zabbix_db"
Z_PASS="1234567"
Z_USER="zabbix_user"

MYSQL_DIR="/docker/mysql/"
APACHE_DIR="/docker/apache"
ZABBIX_DIR="/docker/zabbix"

checa_dir(){
if [ ! -d $1 ]; then
	mkdir -p $1
	chmod 2770 $1
	chown 999:docker $1
fi
}

mysql(){
checa_dir ${MYSQL_DIR}
docker run -d --name zabbix_mysql -p 3306:3306 \
	-v ${MYSQL_DIR}:/var/lib/mysql \
	-e MYSQL_ROOT_PASSWORD=miyagi \
	-e MYSQL_DATABASE=${Z_DB} \
	-e MYSQL_PASSWORD=${Z_PASS} \
	-e MYSQL_USER=${Z_USER} \
	miyaguera/zabbix_mysql 
}


frontend(){
checa_dir ${APACHE_DIR}
docker run -d --name zabbix_frontend -p 80:80 \
	-v ${APACHE_DIR}:/var/log/apache2:rw \
        -e ZABBIX_DB=${Z_DB} \
        -e ZABBIX_PASS=${Z_PASS} \
        -e ZABBIX_USER=${Z_USER}  \
	--link zabbix_mysql:mysql \
	miyaguera/zabbix_frontend
}


zabbix(){
checa_dir ${ZABBIX_DIR}
docker run -d --name zabbix_server  -p 5000:5000 \
	-v ${ZABBIX_DIR}:/var/log/zabbix:rw \
	-e ZABBIX_DB=${Z_DB} \
	-e ZABBIX_PASS=${Z_PASS} \
	-e ZABBIX_USER=${Z_USER}  \
	--link zabbix_mysql:mysql \
	miyaguera/zabbix_server
}


case $1 in 
	mysql|1)
	mysql;;

	zabbix|2)
	zabbix;;

	frontend|3)
	frontend;;
	
	all|4)
	mysql
	zabbix;;	

	*)

	echo "Opcoes (mysql|1), (zabbix|2), (frontend|3) ou (all|4)."
esac

