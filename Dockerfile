From ubuntu:20.04

RUN apt-get update && apt-get install -y software-properties-common apt-utils

RUN export DEBIAN_FRONTEND=noninteractive

RUN add-apt-repository -y ppa:ondrej/php

RUN apt-get update

RUN apt-get install -y git vim \
    php7.4-cli php7.4-fpm php7.4-json php7.4 php7.4-xml php7.4-mysql php7.4-curl php7.4-redis php7.4-json \
    php7.4-bz2 php7.4-zip php7.4-sqlite3 php7.4-intl php7.4-mbstring

RUN apt-get install -y mysql-server-8.0

COPY /fpm/php.ini /etc/php/7.4/fpm/
COPY /fpm/php-fpm.conf /etc/php/7.4/fpm/
COPY ./fpm/pool.d/www.conf /etc/php/7.4/fpm/pool.d/
COPY ./cli/php.ini /etc/php/7.4/cli/

COPY main.sh /root/

RUN apt-get clean && rm -fr /var/lib/apt/list/*

ENTRYPOINT ["/root/main.sh"]
