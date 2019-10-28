From ubuntu:bionic

COPY sources.list /etc/apt/

RUN apt-get update && apt-get install -y aptitude  software-properties-common apt-utils && aptitude update


RUN export DEBIAN_FRONTEND=noninteractive && \
    ln -fs /usr/share/zoneinfo/Asia/Taipei /etc/localtime && \
    aptitude install -y tzdata && \
    dpkg-reconfigure --frontend noninteractive tzdata

RUN add-apt-repository -y ppa:ondrej/php

RUN aptitude update

RUN aptitude install -y git vim \
    php7.2-cli php7.2-fpm php7.2-json php7.2 php7.2-xml php7.2-mysql php7.2-curl php7.2-redis php7.2-json \
    php7.2-bz2 php7.2-zip php7.2-sqlite3 php7.2-intl php7.2-mbstring

COPY /fpm/php.ini /etc/php/7.2/fpm/
COPY /fpm/php-fpm.conf /etc/php/7.2/fpm/
COPY ./fpm/pool.d/www.conf /etc/php/7.2/fpm/pool.d/

COPY ./cli/php.ini /etc/php/7.2/cli/

RUN apt-get clean

RUN service php7.2-fpm restart
