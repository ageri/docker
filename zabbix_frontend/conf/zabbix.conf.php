<?php
// Zabbix GUI configuration file.
global $DB;

$DB['TYPE']     = 'MYSQL';
$DB['SERVER']   = '55.55.55.55';
$DB['PORT']     = '0';
$DB['DATABASE'] = 'zabbix_database';
$DB['USER']     = 'zabbix_user';
$DB['PASSWORD'] = 'zabbix_password';

// Schema name. Used for IBM DB2 and PostgreSQL.
$DB['SCHEMA'] = '';

$ZBX_SERVER      = 'localhost';
$ZBX_SERVER_PORT = '10051';
$ZBX_SERVER_NAME = 'teste';

$IMAGE_FORMAT_DEFAULT = IMAGE_FORMAT_PNG;
?>