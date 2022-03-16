#!/bin/bash


sql_init() {
if [[ ! -d mysql/data ]] ; then
mkdir mysql/data && chown -R 1001:1001 mysql/data && echo "=== Каталог mysql/data создан, необходимые права назначены ==="
fi

# create template && envsubst 
source .env

if [[ -z "${GLOBAL_DOMAIN}" ]] ; then
	echo "=== Значение домена в .env файле не задано. Используется default.com ==="
fi
export GLOBAL_DOMAIN=${GLOBAL_DOMAIN:-"default.com"}

envsubst '$$GLOBAL_DOMAIN' < mysql/docker-entrypoint-initdb.d/init.sql.template > mysql/docker-entrypoint-initdb.d/init.sql && echo \
"=== SQL-файл mysql/docker-entrypoint-initdb.d/init.sql успешно подготовлен ==="
}


change_permissions() {
find bitrix/ -type d -exec chmod 0775 {} \; && echo "=== Права для директорий успешно установлены ==="
find bitrix/ -type f -exec chmod 0664 {} \; && echo "=== Права для файлов успешно установлены ==="
}

change_owner() {
if [[ -z "$1" ]] ; then
    echo "Ошибка! Укажите переменную \$USER при запуске скрипта: sudo ./init perm \$USER"
    exit 1
fi
chown -R "$1":101 bitrix/ && echo "=== Владелец $1:101 для папки с проектом успешно установлен ==="
chmod g+s bitrix
}

clear_cache() {
rm -rf bitrix/bitrix/managed_cache/ && echo "=== Кеш успешно очищен ==="
}

case "$1" in
	db)
	echo "=== Подготовка MySQL ==="
	sql_init
	;;
	perm)
	echo "=== Установка прав для папок и файлов ==="
	change_permissions
	;;
	owner)
	echo "=== Установка владельца ==="
	change_owner $2
	;;
	clear-cache)
	echo "=== Очистка управляемого кеша ==="
	clear_cache
	;;
	* )
	echo "Используйте следующие аргументы: "
	echo "./init.sh db до первого запуска проекта для создания каталога БД и SQL-файла"
	echo "./init.sh perm для установки прав"
	echo "./init.sh owner \$USER для установки владельца"
	echo "./init clear-cache для очистки управляемого кеша"
	;;
esac	
