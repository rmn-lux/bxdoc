# bxdoc
Bitrix in Docker

# Инструкция по запуску локального окружения Битрикс в docker-compose
Подробное описание по компонентам можно посмотреть [в блоге](https://it-lux.ru/%D0%B1%D0%B8%D1%82%D1%80%D0%B8%D0%BA%D1%81-%D0%B2-docker/)

- Подразумевается, что битрикс-проект уже существует
- Каталог с кодом битрикса (ядро + код) разместить в корне проекта по пути ./bitrix/.
- В каталоге mysql/docker-entrypoint-initdb.d/ расположить дамп БД
- Сделать скрипт инициализации исполняемым и выполнить **один раз** со следующими аргументами:

`chmod +x init.sh`

`sudo ./init.sh db` - подготовка каталогов MySQL и SQL-файла до первого запуска проекта

`sudo ./init.sh owner $USER` - установка владельца

`sudo ./init.sh perm` - установка прав (**выполняется 3-5 минут**)

`sudo ./init.sh clear-cache` - очистка управляемого кеша

- Выполнить сборку всех образов командой `docker-compose -f docker-compose.build.yaml build`
- Задать переменную окружения в .env файле, указав домен, который резолвится в 127.0.0.1 на хост-машине. По умолчанию - default.com.
- В docker-compose.yaml для сервиса php-fpm в extra_hosts указать локальный IP-адрес в сети Docker, по умолчанию 172.17.0.1. Уточнить, какой адрес в сети докер можно командой `docker network inspect bridge | grep -i gateway`. Данная настройка необходима для прохождения проверки работ сокетов.
- Выполнить запуск `docker-compose up -d`
- В браузере открывать сайт по адресу http://default.com:80

## Обратить внимание:
- При выполнении `sudo ./init.sh owner $USER` каталогу bitrix/ назначается основной владелец, от имени которого запущен скрипт (ваш пользователь), а владелец группы - UID 101 (пользователь Nginx и PHP-FPM в контейнере). Для удобства разработки к каталогу применен SGID, в результате чего **все новые файлы, созданные в каталоге /bitrix будут иметь сразу необходимые права и владельца  - $USER:101**, т.е. при создании файлов ничего дополнительно делать не нужно.
