#!/bin/sh

envsubst '$$BX_MYSQL_DATABASE $$BX_MYSQL_USER $$BX_MYSQL_PASSWORD' < /tmp/settings.php > /var/www/bitrix/bitrix/.settings.php
envsubst '$$BX_MYSQL_DATABASE $$BX_MYSQL_USER $$BX_MYSQL_PASSWORD' < /tmp/dbconn.php > /var/www/bitrix/bitrix/php_interface/dbconn.php
