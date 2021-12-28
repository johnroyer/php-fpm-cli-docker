From ubuntu:20.04

RUN apt-get update && apt-get install -y software-properties-common apt-utils

RUN export DEBIAN_FRONTEND=noninteractive

RUN apt-get install -y mysql-server-8.0

RUN add-apt-repository -y ppa:ondrej/php

RUN apt-get update

RUN apt-get install -y git vim \
    php7.3-cli php7.3-fpm php7.3-json php7.3 php7.3-xml php7.3-mysql php7.3-curl php7.3-redis \
    php7.3-bz2 php7.3-zip php7.3-sqlite3 php7.3-intl php7.3-mbstring

COPY /fpm/php.ini /etc/php/7.3/fpm/
COPY /fpm/php-fpm.conf /etc/php/7.3/fpm/
COPY ./fpm/pool.d/www.conf /etc/php/7.3/fpm/pool.d/
COPY ./cli/php.ini /etc/php/7.3/cli/

COPY main.sh /root/

RUN apt-get clean && rm -fr /var/lib/apt/list/*

ENTRYPOINT ["/root/main.sh"]
