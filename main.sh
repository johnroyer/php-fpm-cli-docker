#!/bin/env bash

usermod -d /var/lib/mysql/ mysql

service mysql start && echo "MySQL started ..."

mysql -u root -e 'CREATE DATABASE test' && \
mysql -u root -e 'CREATE USER test@localhost IDENTIFIED BY "PASSWORD"' && \
mysql -u root -e 'GRANT ALL PRIVILEGES ON test.* to test@localhost; FLUSH PRIVILEGES' && \
echo "Database initialized ..."


service php7.4-fpm start && echo "PHP started ..."
service nginx start && echo "Nginx started ..."
echo ""

tail -f /dev/stderr
