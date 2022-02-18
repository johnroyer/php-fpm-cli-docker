From ubuntu:20.04

RUN apt-get update && apt-get install -y software-properties-common apt-utils

RUN export DEBIAN_FRONTEND=noninteractive

RUN apt-get install -y mysql-server-8.0

RUN add-apt-repository -y ppa:ondrej/php

RUN apt-get update

RUN apt-get install -y git vim \
    php8.0-cli php8.0-fpm php8.0 php8.0-xml php8.0-mysql php8.0-curl php8.0-redis \
    php8.0-bz2 php8.0-zip php8.0-sqlite3 php8.0-intl php8.0-mbstring

COPY /fpm/php.ini /etc/php/8.0/fpm/
COPY /fpm/php-fpm.conf /etc/php/8.0/fpm/
COPY ./fpm/pool.d/www.conf /etc/php/8.0/fpm/pool.d/
COPY ./cli/php.ini /etc/php/8.0/cli/

COPY main.sh /root/

RUN apt-get clean && rm -fr /var/lib/apt/list/*

ENTRYPOINT ["/root/main.sh"]
