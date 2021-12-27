From ubuntu:20.04

RUN apt-get update && apt-get install -y software-properties-common apt-utils

RUN export DEBIAN_FRONTEND=noninteractive

RUN apt-get install -y mysql-server-8.0

RUN add-apt-repository -y ppa:ondrej/php

RUN apt-get update

RUN apt-get install -y git vim \
    php8.1-cli php8.1-fpm php8.1 php8.1-xml php8.1-mysql php8.1-curl php8.1-redis \
    php8.1-bz2 php8.1-zip php8.1-sqlite3 php8.1-intl php8.1-mbstring

COPY /fpm/php.ini /etc/php/8.1/fpm/
COPY /fpm/php-fpm.conf /etc/php/8.1/fpm/
COPY ./fpm/pool.d/www.conf /etc/php/8.1/fpm/pool.d/
COPY ./cli/php.ini /etc/php/8.1/cli/

COPY main.sh /root/

RUN apt-get clean && rm -fr /var/lib/apt/list/*

ENTRYPOINT ["/root/main.sh"]
