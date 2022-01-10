From ubuntu:bionic

COPY sources.list /etc/apt/

RUN apt-get update && apt-get install -y aptitude  software-properties-common apt-utils && aptitude update

RUN export DEBIAN_FRONTEND=noninteractive

RUN apt-get install -y mysql-server-8.0

RUN add-apt-repository -y ppa:ondrej/php

RUN aptitude update

RUN aptitude install -y git vim \
    php7.1-cli php7.1-fpm php7.1 php7.1-xml php7.1-mysql php7.1-curl php7.1-redis php7.1-json \
    php7.1-bz2 php7.1-zip php7.1-sqlite3 php7.1-intl php7.1-mbstring

COPY /fpm/php.ini /etc/php/7.1/fpm/
COPY /fpm/php-fpm.conf /etc/php/7.1/fpm/
COPY ./fpm/pool.d/www.conf /etc/php/7.1/fpm/pool.d/

COPY ./cli/php.ini /etc/php/7.1/cli/

RUN apt-get clean

RUN service php7.1-fpm restart
