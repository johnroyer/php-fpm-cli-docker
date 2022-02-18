From ubuntu:20.04


RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true  apt-get install -y software-properties-common apt-utils

RUN apt-get install -y mysql-server-8.0

RUN add-apt-repository -y ppa:ondrej/php

RUN apt-get update

RUN apt-get install -y git vim \
    php7.4-cli php7.1-fpm php7.1 php7.1-xml php7.1-mysql php7.1-curl php7.1-redis php7.1-json \
    php7.4-bz2 php7.1-zip php7.1-sqlite3 php7.1-intl php7.1-mbstring

COPY /fpm/php.ini /etc/php/7.4/fpm/
COPY /fpm/php-fpm.conf /etc/php/7.4/fpm/
COPY ./fpm/pool.d/www.conf /etc/php/7.4/fpm/pool.d/

COPY ./cli/php.ini /etc/php/7.4/cli/

COPY main.sh /root/

RUN apt-get clean && rm -fr /var/lib/apt/list/*

ENTRYPOINT ["/root/main.sh"]
