FROM nginx:1.21.1-alpine

COPY conf/default.conf.template /etc/nginx/templates/
COPY conf/envsubst_cred.sh /docker-entrypoint.d
COPY conf/dbconn.php /tmp/
COPY conf/settings.php /tmp/

RUN chown -R 101:101 /tmp/dbconn.php && \
	chown -R 101:101 /tmp/settings.php
